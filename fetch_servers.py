#!/usr/bin/env python3
"""
Server Masterlist Fetcher
Bu script, çeşitli masterlist kaynaklarından sunucu listelerini almak için kullanılır.
This script is used to fetch server lists from various masterlist sources.

Desteklenen formatlar / Supported formats:
- HTTP/JSON masterlist
- Steam/Valve masterlist protocol
- Basit metin tabanlı listeler / Simple text-based lists
"""

import argparse
import socket
import struct
import sys
import json
from typing import List, Dict, Tuple
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError


class MasterlistFetcher:
    """
    Sunucu masterlist'lerini almak için ana sınıf
    Main class for fetching server masterlists
    
    Supports multiple protocols:
    - HTTP/JSON: JSON formatted server lists via HTTP
    - HTTP/Text: Plain text server lists via HTTP
    - Valve/Steam: Steam masterlist protocol for Source engine games
    
    Usage:
        fetcher = MasterlistFetcher()
        servers = fetcher.fetch_http_json("https://example.com/servers.json")
        servers = fetcher.fetch_valve_masterlist(app_id=240)
    """
    
    def __init__(self):
        self.timeout = 5
        
    def fetch_http_json(self, url: str) -> List[Dict]:
        """
        HTTP üzerinden JSON formatında sunucu listesi alır
        Fetches server list in JSON format over HTTP
        
        Args:
            url: Masterlist URL'si / Masterlist URL
            
        Returns:
            Sunucu listesi / List of servers
        """
        try:
            req = Request(url)
            req.add_header('User-Agent', 'Mozilla/5.0 (Server Fetcher)')
            
            with urlopen(req, timeout=self.timeout) as response:
                data = response.read()
                servers = json.loads(data)
                
                if isinstance(servers, list):
                    return servers
                elif isinstance(servers, dict) and 'servers' in servers:
                    return servers['servers']
                else:
                    return [servers]
                    
        except HTTPError as e:
            print(f"HTTP Hatası / HTTP Error: {e.code} - {e.reason}", file=sys.stderr)
            return []
        except URLError as e:
            print(f"URL Hatası / URL Error: {e.reason}", file=sys.stderr)
            return []
        except json.JSONDecodeError as e:
            print(f"JSON Parse Hatası / JSON Parse Error: {e}", file=sys.stderr)
            return []
        except Exception as e:
            print(f"Beklenmeyen hata / Unexpected error: {e}", file=sys.stderr)
            return []
    
    def fetch_http_text(self, url: str) -> List[str]:
        """
        HTTP üzerinden metin formatında sunucu listesi alır
        Fetches server list in text format over HTTP
        
        Args:
            url: Masterlist URL'si / Masterlist URL
            
        Returns:
            Sunucu adresleri listesi / List of server addresses
        """
        try:
            req = Request(url)
            req.add_header('User-Agent', 'Mozilla/5.0 (Server Fetcher)')
            
            with urlopen(req, timeout=self.timeout) as response:
                data = response.read().decode('utf-8')
                servers = [line.strip() for line in data.split('\n') if line.strip()]
                return servers
                
        except Exception as e:
            print(f"Hata / Error: {e}", file=sys.stderr)
            return []
    
    def _build_masterlist_query(self, seed: str, region: int, app_id: int = 0) -> bytes:
        """
        Valve masterlist protokolü için sorgu paketi oluşturur
        Builds query packet for Valve masterlist protocol
        
        Args:
            seed: Başlangıç adresi (örn: "0.0.0.0:0") / Starting address (e.g., "0.0.0.0:0")
            region: Bölge kodu / Region code
            app_id: Steam uygulama ID (opsiyonel) / Steam application ID (optional)
            
        Returns:
            Sorgu paketi / Query packet
        """
        # Format: 0x31 (query byte) + region + seed + null + optional filter
        query = struct.pack('B', 0x31) + struct.pack('B', region) + seed.encode() + b'\x00'
        
        if app_id > 0:
            query += f"\\appid\\{app_id}".encode() + b'\x00'
        
        return query
    
    def fetch_valve_masterlist(self, masterlist_ip: str = "hl2master.steampowered.com", 
                               masterlist_port: int = 27011, 
                               region: int = 0xFF,
                               app_id: int = 0) -> List[Tuple[str, int]]:
        """
        Valve/Steam masterlist protokolünü kullanarak sunucu listesi alır
        Fetches server list using Valve/Steam masterlist protocol
        
        Args:
            masterlist_ip: Masterlist sunucu IP/hostname
            masterlist_port: Masterlist sunucu portu / port
            region: Bölge kodu (0xFF = tüm dünya) / Region code (0xFF = all)
            app_id: Steam uygulama ID'si / Steam application ID
            
        Returns:
            (IP, Port) tuple listesi / List of (IP, Port) tuples
        """
        servers = []
        
        try:
            # Socket oluştur / Create socket
            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            sock.settimeout(self.timeout)
            
            # Masterlist sunucusuna bağlan / Connect to masterlist server
            masterlist_addr = (socket.gethostbyname(masterlist_ip), masterlist_port)
            
            # İlk sorgu paketi / Initial query packet
            seed = "0.0.0.0:0"
            query = self._build_masterlist_query(seed, region, app_id)
            sock.sendto(query, masterlist_addr)
            
            # Sunucuları al / Receive servers
            while True:
                try:
                    data, addr = sock.recvfrom(4096)
                    
                    # İlk 6 byte header (0xFF 0xFF 0xFF 0xFF 0x66 0x0A)
                    if len(data) < 6 or data[4:6] != b'\x66\x0a':
                        break
                    
                    # Sunucu adreslerini parse et / Parse server addresses
                    offset = 6
                    last_ip = None
                    last_port = None
                    
                    while offset + 6 <= len(data):
                        # 4 byte IP + 2 byte port (big-endian)
                        ip_bytes = data[offset:offset+4]
                        port_bytes = data[offset+4:offset+6]
                        
                        ip = '.'.join(str(b) for b in ip_bytes)
                        port = struct.unpack('>H', port_bytes)[0]
                        
                        # Son adres 0.0.0.0:0 ise bitir / End if last address is 0.0.0.0:0
                        if ip == '0.0.0.0' and port == 0:
                            return servers
                        
                        servers.append((ip, port))
                        last_ip = ip
                        last_port = port
                        
                        offset += 6
                    
                    # Batch işlendikten sonra bir sonraki batch için sorgu gönder
                    # Send query for next batch after processing current batch
                    if last_ip and last_port:
                        seed = f"{last_ip}:{last_port}"
                        query = self._build_masterlist_query(seed, region, app_id)
                        sock.sendto(query, masterlist_addr)
                        
                except socket.timeout:
                    break
                    
            sock.close()
            return servers
            
        except Exception as e:
            print(f"Valve masterlist hatası / Valve masterlist error: {e}", file=sys.stderr)
            return []


def main():
    parser = argparse.ArgumentParser(
        description='Sunucu masterlist\'lerinden sunucu listesi alır / Fetches server lists from masterlists',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Örnekler / Examples:
  # HTTP/JSON masterlist
  %(prog)s --type json --url https://example.com/servers.json
  
  # HTTP metin listesi / HTTP text list
  %(prog)s --type text --url https://example.com/servers.txt
  
  # Valve/Steam masterlist (Counter-Strike: Source örneği)
  %(prog)s --type valve --app-id 240
  
  # Valve/Steam masterlist (özel masterlist sunucusu)
  %(prog)s --type valve --masterlist-ip hl2master.steampowered.com --masterlist-port 27011
        """
    )
    
    parser.add_argument('--type', choices=['json', 'text', 'valve'], required=True,
                       help='Masterlist tipi / Masterlist type')
    parser.add_argument('--url', help='HTTP URL (json ve text tipleri için / for json and text types)')
    parser.add_argument('--masterlist-ip', default='hl2master.steampowered.com',
                       help='Valve masterlist IP/hostname (varsayılan: hl2master.steampowered.com)')
    parser.add_argument('--masterlist-port', type=int, default=27011,
                       help='Valve masterlist portu / port (varsayılan: 27011)')
    parser.add_argument('--app-id', type=int, default=0,
                       help='Steam uygulama ID (Valve masterlist için / for Valve masterlist)')
    parser.add_argument('--output', choices=['json', 'text'], default='text',
                       help='Çıktı formatı / Output format (varsayılan: text)')
    
    args = parser.parse_args()
    
    fetcher = MasterlistFetcher()
    
    # Masterlist tipine göre sunucuları al / Fetch servers based on masterlist type
    if args.type == 'json':
        if not args.url:
            print("Hata: --url parametresi gerekli / Error: --url parameter required", file=sys.stderr)
            sys.exit(1)
        servers = fetcher.fetch_http_json(args.url)
        
    elif args.type == 'text':
        if not args.url:
            print("Hata: --url parametresi gerekli / Error: --url parameter required", file=sys.stderr)
            sys.exit(1)
        servers = fetcher.fetch_http_text(args.url)
        
    elif args.type == 'valve':
        servers = fetcher.fetch_valve_masterlist(
            args.masterlist_ip, 
            args.masterlist_port,
            app_id=args.app_id
        )
    else:
        print(f"Desteklenmeyen tip / Unsupported type: {args.type}", file=sys.stderr)
        sys.exit(1)
    
    # Sonuçları göster / Display results
    if not servers:
        print("Hiç sunucu bulunamadı / No servers found", file=sys.stderr)
        sys.exit(1)
    
    print(f"\nToplam {len(servers)} sunucu bulundu / Total {len(servers)} servers found\n")
    
    # Çıktı formatına göre yazdır / Print based on output format
    if args.output == 'json':
        print(json.dumps(servers, indent=2, ensure_ascii=False))
    else:
        for i, server in enumerate(servers, 1):
            if isinstance(server, tuple):
                print(f"{i}. {server[0]}:{server[1]}")
            elif isinstance(server, dict):
                # JSON objesi ise önemli alanları göster / Show important fields if JSON object
                if 'ip' in server and 'port' in server:
                    print(f"{i}. {server['ip']}:{server['port']}")
                elif 'address' in server:
                    print(f"{i}. {server['address']}")
                elif 'host' in server:
                    print(f"{i}. {server['host']}")
                else:
                    print(f"{i}. {server}")
            else:
                print(f"{i}. {server}")


if __name__ == '__main__':
    main()
