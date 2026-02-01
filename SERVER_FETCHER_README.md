# Server Masterlist Fetcher / Sunucu Masterlist Alıcı

Bu Python scripti, çeşitli masterlist kaynaklarından sunucu listelerini almak için kullanılır.

This Python script is used to fetch server lists from various masterlist sources.

## Özellikler / Features

- ✅ HTTP/JSON formatında masterlist desteği / HTTP/JSON masterlist support
- ✅ HTTP metin formatında masterlist desteği / HTTP text format masterlist support  
- ✅ Valve/Steam masterlist protokolü desteği / Valve/Steam masterlist protocol support
- ✅ Hata yönetimi / Error handling
- ✅ Çıktı formatı seçenekleri (JSON/Text) / Output format options (JSON/Text)
- ✅ Türkçe ve İngilizce dil desteği / Turkish and English language support

## Kurulum / Installation

Script Python 3'ün standart kütüphanelerini kullanır, ekstra paket kurulumu gerekmez.

The script uses Python 3's standard libraries, no additional package installation required.

```bash
# Script'i çalıştırılabilir yap / Make the script executable
chmod +x fetch_servers.py
```

## Kullanım / Usage

### 1. HTTP/JSON Masterlist

JSON formatında sunucu listesi sunan bir HTTP endpoint'ten sunucuları almak için:

To fetch servers from an HTTP endpoint serving a JSON server list:

```bash
python3 fetch_servers.py --type json --url https://example.com/api/servers.json
```

Örnek JSON formatları / Example JSON formats:
```json
[
  {"ip": "192.168.1.1", "port": 27015, "name": "Server 1"},
  {"ip": "192.168.1.2", "port": 27015, "name": "Server 2"}
]
```

veya / or:

```json
{
  "servers": [
    {"address": "192.168.1.1:27015"},
    {"address": "192.168.1.2:27015"}
  ]
}
```

### 2. HTTP Metin Listesi / HTTP Text List

Metin formatında sunucu listesi sunan bir HTTP endpoint'ten sunucuları almak için:

To fetch servers from an HTTP endpoint serving a text server list:

```bash
python3 fetch_servers.py --type text --url https://example.com/servers.txt
```

Örnek metin formatı (her satırda bir sunucu) / Example text format (one server per line):
```
192.168.1.1:27015
192.168.1.2:27015
server.example.com:27015
```

### 3. Valve/Steam Masterlist Protokolü

Valve'ın masterlist protokolünü kullanarak Steam oyun sunucularını almak için:

To fetch Steam game servers using Valve's masterlist protocol:

```bash
# Counter-Strike: Source sunucuları (App ID: 240)
python3 fetch_servers.py --type valve --app-id 240

# Team Fortress 2 sunucuları (App ID: 440)
python3 fetch_servers.py --type valve --app-id 440

# Half-Life 2: Deathmatch sunucuları (App ID: 320)
python3 fetch_servers.py --type valve --app-id 320

# Tüm Source engine sunucuları (App ID belirtilmezse)
python3 fetch_servers.py --type valve
```

Özel masterlist sunucusu kullanmak için / To use a custom masterlist server:

```bash
python3 fetch_servers.py --type valve \
  --masterlist-ip hl2master.steampowered.com \
  --masterlist-port 27011 \
  --app-id 240
```

### Çıktı Formatı Seçenekleri / Output Format Options

#### Metin Çıktısı (Varsayılan) / Text Output (Default)

```bash
python3 fetch_servers.py --type valve --app-id 240 --output text
```

Çıktı / Output:
```
Toplam 150 sunucu bulundu / Total 150 servers found

1. 192.168.1.1:27015
2. 192.168.1.2:27015
3. 10.0.0.1:27016
...
```

#### JSON Çıktısı / JSON Output

```bash
python3 fetch_servers.py --type valve --app-id 240 --output json
```

Çıktı / Output:
```json
[
  ["192.168.1.1", 27015],
  ["192.168.1.2", 27015],
  ["10.0.0.1", 27016]
]
```

JSON çıktısını dosyaya kaydetmek için / To save JSON output to a file:

```bash
python3 fetch_servers.py --type valve --app-id 240 --output json > servers.json
```

## Yaygın Steam Oyun App ID'leri / Common Steam Game App IDs

| Oyun / Game | App ID |
|------------|--------|
| Counter-Strike: Source | 240 |
| Team Fortress 2 | 440 |
| Counter-Strike: Global Offensive | 730 |
| Half-Life 2: Deathmatch | 320 |
| Day of Defeat: Source | 300 |
| Left 4 Dead | 500 |
| Left 4 Dead 2 | 550 |
| Garry's Mod | 4000 |

Tam liste için: https://developer.valvesoftware.com/wiki/Steam_Application_IDs

## Parametreler / Parameters

```
--type {json,text,valve}     Masterlist tipi (zorunlu) / Masterlist type (required)
--url URL                     HTTP URL (json ve text tipleri için / for json and text types)
--masterlist-ip IP            Valve masterlist IP/hostname (varsayılan: hl2master.steampowered.com)
--masterlist-port PORT        Valve masterlist portu / port (varsayılan: 27011)
--app-id ID                   Steam uygulama ID (Valve masterlist için / for Valve masterlist)
--output {json,text}          Çıktı formatı / Output format (varsayılan: text)
```

## Hata Ayıklama / Troubleshooting

### "Hiç sunucu bulunamadı" / "No servers found"

- URL'in doğru olduğundan emin olun / Make sure the URL is correct
- İnternet bağlantınızı kontrol edin / Check your internet connection
- Firewall kurallarını kontrol edin / Check firewall rules
- Valve masterlist için doğru App ID kullandığınızdan emin olun / For Valve masterlist, ensure you're using the correct App ID

### Zaman Aşımı Hataları / Timeout Errors

- Ağ bağlantınızı kontrol edin / Check your network connection
- Uzak sunucu yanıt vermiyor olabilir / The remote server may not be responding
- Timeout süresini artırmak için script'i düzenleyebilirsiniz / You can edit the script to increase timeout duration

## Lisans / License

Bu script, repository'nin genel lisansı altında sunulmaktadır.

This script is provided under the general license of the repository.

## Katkıda Bulunma / Contributing

Önerileriniz ve katkılarınız için pull request açabilirsiniz.

Feel free to open pull requests for suggestions and contributions.
