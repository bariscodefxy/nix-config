#!/usr/bin/env python3
"""
Örnek Kullanım / Example Usage
Bu dosya fetch_servers.py scriptinin nasıl kullanılacağını gösterir.
This file demonstrates how to use the fetch_servers.py script.
"""

import subprocess
import json

def example_fetch_json():
    """HTTP/JSON formatında sunucu listesi alma örneği / Example of fetching JSON server list"""
    print("=" * 60)
    print("Örnek 1: HTTP/JSON Masterlist")
    print("Example 1: HTTP/JSON Masterlist")
    print("=" * 60)
    
    # Örnek JSON endpoint'i (gerçek bir URL kullanın)
    # Example JSON endpoint (use a real URL)
    url = "https://api.example.com/servers.json"
    
    print(f"\nKomut / Command:")
    print(f"python3 fetch_servers.py --type json --url {url}")
    print("\nBeklenen çıktı / Expected output:")
    print("Toplam X sunucu bulundu / Total X servers found\n")
    print("1. 192.168.1.1:27015")
    print("2. 192.168.1.2:27015")
    print("...")

def example_fetch_text():
    """HTTP metin formatında sunucu listesi alma örneği / Example of fetching text server list"""
    print("\n" + "=" * 60)
    print("Örnek 2: HTTP Metin Listesi")
    print("Example 2: HTTP Text List")
    print("=" * 60)
    
    url = "https://example.com/servers.txt"
    
    print(f"\nKomut / Command:")
    print(f"python3 fetch_servers.py --type text --url {url}")
    print("\nBeklenen çıktı / Expected output:")
    print("Toplam X sunucu bulundu / Total X servers found\n")
    print("1. server1.example.com:27015")
    print("2. server2.example.com:27015")
    print("...")

def example_fetch_valve_css():
    """Counter-Strike: Source sunucuları alma örneği / Example of fetching CS:S servers"""
    print("\n" + "=" * 60)
    print("Örnek 3: Counter-Strike: Source Sunucuları")
    print("Example 3: Counter-Strike: Source Servers")
    print("=" * 60)
    
    print("\nKomut / Command:")
    print("python3 fetch_servers.py --type valve --app-id 240")
    print("\nBu komut Valve'ın masterlist sunucusuna bağlanır ve")
    print("Counter-Strike: Source sunucularını listeler.")
    print("\nThis command connects to Valve's masterlist server and")
    print("lists Counter-Strike: Source servers.")

def example_fetch_valve_tf2():
    """Team Fortress 2 sunucuları alma örneği / Example of fetching TF2 servers"""
    print("\n" + "=" * 60)
    print("Örnek 4: Team Fortress 2 Sunucuları")
    print("Example 4: Team Fortress 2 Servers")
    print("=" * 60)
    
    print("\nKomut / Command:")
    print("python3 fetch_servers.py --type valve --app-id 440 --output json > tf2_servers.json")
    print("\nBu komut TF2 sunucularını JSON formatında alır ve dosyaya kaydeder.")
    print("This command fetches TF2 servers in JSON format and saves to a file.")

def example_local_test():
    """Yerel test örneği / Local testing example"""
    print("\n" + "=" * 60)
    print("Örnek 5: Yerel Test")
    print("Example 5: Local Testing")
    print("=" * 60)
    
    print("\n1. Test JSON dosyası oluştur / Create test JSON file:")
    print('cat > /tmp/servers.json << EOF')
    print('[')
    print('  {"ip": "192.168.1.1", "port": 27015},')
    print('  {"ip": "192.168.1.2", "port": 27015}')
    print(']')
    print('EOF')
    
    print("\n2. Yerel HTTP sunucusu başlat / Start local HTTP server:")
    print("python3 -m http.server 8000 --directory /tmp &")
    
    print("\n3. Script'i test et / Test the script:")
    print("python3 fetch_servers.py --type json --url http://localhost:8000/servers.json")
    
    print("\n4. Sunucuyu durdur / Stop the server:")
    print("kill %1")

def example_common_app_ids():
    """Yaygın Steam oyun App ID'leri / Common Steam game App IDs"""
    print("\n" + "=" * 60)
    print("Örnek 6: Yaygın Steam Oyun App ID'leri")
    print("Example 6: Common Steam Game App IDs")
    print("=" * 60)
    
    games = [
        ("Counter-Strike: Source", 240),
        ("Team Fortress 2", 440),
        ("Counter-Strike: Global Offensive", 730),
        ("Half-Life 2: Deathmatch", 320),
        ("Day of Defeat: Source", 300),
        ("Left 4 Dead", 500),
        ("Left 4 Dead 2", 550),
        ("Garry's Mod", 4000),
    ]
    
    print("\nOyun / Game                           App ID    Komut / Command")
    print("-" * 80)
    for game_name, app_id in games:
        cmd = f"python3 fetch_servers.py --type valve --app-id {app_id}"
        print(f"{game_name:<35} {app_id:<9} {cmd}")

def example_save_to_file():
    """Sonuçları dosyaya kaydetme örneği / Example of saving results to file"""
    print("\n" + "=" * 60)
    print("Örnek 7: Sonuçları Dosyaya Kaydetme")
    print("Example 7: Saving Results to File")
    print("=" * 60)
    
    print("\nMetin formatında / Text format:")
    print("python3 fetch_servers.py --type valve --app-id 240 > cs_servers.txt")
    
    print("\nJSON formatında / JSON format:")
    print("python3 fetch_servers.py --type valve --app-id 440 --output json > tf2_servers.json")
    
    print("\nDosyayı okumak için / To read the file:")
    print("cat cs_servers.txt")
    print("# veya / or")
    print("cat tf2_servers.json | python3 -m json.tool")

def main():
    print("\n")
    print("╔" + "=" * 78 + "╗")
    print("║" + " " * 20 + "FETCH_SERVERS.PY KULLANIM ÖRNEKLERİ" + " " * 22 + "║")
    print("║" + " " * 20 + "FETCH_SERVERS.PY USAGE EXAMPLES" + " " * 27 + "║")
    print("╚" + "=" * 78 + "╝")
    
    example_fetch_json()
    example_fetch_text()
    example_fetch_valve_css()
    example_fetch_valve_tf2()
    example_local_test()
    example_common_app_ids()
    example_save_to_file()
    
    print("\n" + "=" * 60)
    print("Daha fazla bilgi için / For more information:")
    print("python3 fetch_servers.py --help")
    print("cat SERVER_FETCHER_README.md")
    print("=" * 60 + "\n")

if __name__ == "__main__":
    main()
