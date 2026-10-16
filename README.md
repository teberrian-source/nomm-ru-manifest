# nomm-ru-manifest

Русскоязычные описания модов для **NOMM — Nuclear Option Mod Manager**.

## Что это

NOMM (менеджер модов Nuclear Option) берёт список модов из реестра [NOMNOM](https://github.com/KopterBuzz/NOMNOM) — манифест `manifest.json` на английском. Этот проект — **готовый к употреблению манифест** с русскими описаниями **всех 238 модов** реестра.

Интерфейс самого менеджера при этом остаётся английским — переводятся только описания модов.

## Как использовать (локальный сервер)

1. Запустите `start-server.bat` (порт 8765, файлы раздаются из `dist/`).
2. Откройте NOMM → **Settings**.
3. В блоке **Manifest** замените:
   - `Manifest Source URL` → `http://localhost:8765/manifest.json`
   - `Manifest Version Source URL` → `http://localhost:8765/version.json`
4. Список модов перезагрузится с русскими описаниями.

Чтобы вернуть английские описания — вставьте обратно официальные URL:
`https://kopterbuzz.github.io/NOMNOM/manifest/manifest.json` и `.../version.json`.

## Как использовать (GitHub, после публикации репозитория)

- `Manifest Source URL` → `https://raw.githubusercontent.com/<ВАШ-ЛОГИН>/nomm-ru-manifest/main/dist/manifest.json`
- `Manifest Version Source URL` → `https://raw.githubusercontent.com/<ВАШ-ЛОГИН>/nomm-ru-manifest/main/dist/version.json`

Установка, обновления и проверка хэшей модов продолжают работать — меняем только источник описаний, сами ссылки на скачивание (`downloadUrl`) и хэши остаются оригинальными.

## Структура

- `manifest.upstream.json` — снимок официального манифеста NOMNOM (источник).
- `translations.ru.json` — русские описания, ключ = id мода.
- `build.ps1` — применяет переводы к снимку и выпускает `dist/manifest.json` + `dist/version.json`.
- `dist/` — готовые файлы для NOMM.

## Обновление переводов

1. Скачать свежий манифест: `https://kopterbuzz.github.io/NOMNOM/manifest/manifest.json` → заменить `manifest.upstream.json`.
2. Добавить новые id в `translations.ru.json` (без перевода остаются новые моды — сборщик их перечислит).
3. Запустить: `powershell -ExecutionPolicy Bypass -File build.ps1 -Version <новая-версия>` (версию поднимать обязательно, иначе NOMM не перечитает список).
4. Закоммитить и запушить `dist/`.

## Ограничения

- Переведены описания всех 238 модов текущего снимка; после обновления `manifest.upstream.json` новые моды появятся с английскими описаниями, пока для них не добавят перевод.
- Названия модов, теги и ссылки не переводятся — это имена собственные и технические идентификаторы.
