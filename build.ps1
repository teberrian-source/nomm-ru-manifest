# Сборка переведённого манифеста NOMNOM для NOMM.
# Берёт manifest.upstream.json, применяет русские описания из translations.ru.json
# и выпускает manifest.json + version.json для размещения на GitHub Pages / raw.
param(
    # Выходная версия манифеста. NOMM сравнивает её со старой, чтобы решить, перезагружать ли список.
    [string]$Version = "1.0.0"
)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$upstream = Get-Content "$root\manifest.upstream.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$translations = Get-Content "$root\translations.ru.json" -Raw -Encoding UTF8 | ConvertFrom-Json

$applied = 0
$missing = @()
foreach ($mod in $upstream) {
    $id = $mod.id
    $tr = $translations.PSObject.Properties[$id]
    if ($null -ne $tr) {
        $mod.description = $tr.Value
        $applied++
    } else {
        $missing += $id
    }
}

# Проверка целостности: все id уникальны, количество модов не изменилось
$ids = $upstream | ForEach-Object { $_.id }
if (($ids | Sort-Object -Unique).Count -ne $upstream.Count) {
    throw "Найдены дубликаты id в манифесте!"
}

# Выпуск: manifest.json (JSON-массив, как оригинал) и version.json (строка версии)
$outDir = "$root\dist"
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText("$outDir\manifest.json", ($upstream | ConvertTo-Json -Depth 20), $utf8NoBom)
[System.IO.File]::WriteAllText("$outDir\version.json", ('"' + $Version + '"'), $utf8NoBom)

"Применено переводов: $applied из $($upstream.Count)"
if ($missing.Count -gt 0) {
    "Без перевода (остались английскими): $($missing.Count)"
    $missing -join ', '
}
"Готово: $outDir\manifest.json, $outDir\version.json (version=$Version)"
