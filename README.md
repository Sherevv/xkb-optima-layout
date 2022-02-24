# Раскладка Optima

Универсальная типографская раскладка для Linux. 
Частично соответствует раскладке Ильи Бирмана (версия 3.7)[^1], но изменены положения некоторых символов русской и английской
раскладки.  

Для удобства набора дополнительных символов (`&`, `\``), скобочек (`{}`, `[]`, `<>`) в обеих раскладках, они вынесены в третий слой.

### Установка:

```bash
# клонируйте репозиторий (или просто скачайте его)
git clone https://github.com/Sherevv/xkb-optima-layout.git
cd xkb-optima

# создайте в домашней директории папку для раскладки
mkdir -p ~/.config/xkb/symbols/

# скопируйте туда файл раскладки
cp optima ~/.config/xkb/symbols/
```

Добавьте следующий код на выполнение при загрузке системы.

```bash
setxkbmap -layout 'us+optima+enfix,ru:2+optima:2+rufix' -option 'grp:alt_shift_toggle,grp:caps_toggle,lv3:ralt_switch,lv3:win_switch,compose:rctrl,compose:menu' -print | xkbcomp -I${HOME}/.config/xkb - $DISPLAY
```

`grp:alt_shift_toggle` означает, что переключение раскладки осуществляется комбинацией `Alt+Shit`.

`lv3:ralt_switch` добавляет включение дополнительного слоя нажатием правого `Alt`.

`compose:rctrl` активирует Compose режим правым `Ctrl`.

Другие варианты переключений можно посмотреть в файле `/usr/share/X11/xkb/rules/base.lst` под блоком `! option`.

Либо вы можете воспользоваться готовым скриптом, который создаст папку `~/.config/xkb/symbols/`, скопирует туда файл `optima`, добавит команду `setxkbmap` в `~/.xprofile` и активирует раскладку.
```bash
./install.sh
```

## Полезное

[^1]: [Реализация раскладки Бирмана 3.7](https://github.com/sherevv/xkb-birman)

Универсальные раскладки:

[https://github.com/tonsky/Universal-Layout/](https://github.com/tonsky/Universal-Layout/)

[https://github.com/braindefender/universal-layout](https://github.com/braindefender/universal-layout)
