

# Ignore settings configured via autoconfig.yml
config.load_autoconfig(False)

# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# {{{ Import Statements
from qutebrowser.api import interceptor
from qutebrowser.api import cmdutils
# }}}

# {{{ Bindings
# Bindings for normal mode
config.bind(";m", "hint links spawn mpv {hint-url}")
config.bind(",b", "spawn --userscript qute-bitwarden")
config.bind("<Ctrl-o>", "back")
config.bind("<Ctrl-i>", "forward")
config.bind("xs", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind('xx', 'config-cycle tabs.show always never;; config-cycle statusbar.show always never')
config.bind("cl", "tab-only --next")
config.bind("cr", "tab-only --prev")
config.bind("cm", "clear-messages")
config.bind("gd", "download-open")
config.bind("o", "spawn --userscript rofi-menu open")
config.bind("O", "spawn --userscript rofi-menu tab")
config.bind("<Ctrl-Shift-o>", "spawn --userscript rofi-menu open copy")
config.bind("<Ctrl-Shift-O>", "spawn --userscript rofi-menu tab copy")
config.bind("<Alt-o>", "spawn --userscript rofi-menu open touch")
config.bind("<Alt-O>", "spawn --userscript rofi-menu tab touch")
config.bind("b", "spawn --userscript rofi-menu marks")
config.bind("B", "spawn --userscript rofi-menu marks-tab")
config.bind("<Alt-b>", "spawn --userscript rofi-menu marks touch")
config.bind("<Alt-B>", "spawn --userscript rofi-menu marks-tab touch")

# Bindings for insert mode
config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")


# }}}
# {{{ Options
c.content.pdfjs = False
c.hints.chars = "arstdhneio"
c.content.autoplay = False

# UX
c.fonts.default_family = '"SFMono"'
c.fonts.default_size = "10pt"
c.tabs.show = "always"
c.statusbar.show = "always"

# Default Pages
# c.url.default_page = "/home/fabian/.dotfiles/config/qutebrowser/index.html"
# c.url.start_pages = "/home/fabian/.dotfiles/config/qutebrowser/index.html"
c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"

# File Selection
config.set("fileselect.handler", "external")
config.set("fileselect.single_file.command", ['alacritty', '--class', 'ranger,ranger', '-e', 'ranger', '--choosefile', '{}'])
config.set("fileselect.multiple_files.command", ['alacritty', '--class', 'ranger,ranger', '-e', 'ranger', '--choosefiles', '{}'])
# }}}
# {{{ Stylesheets
config.bind('td', 'config-cycle colors.webpage.darkmode.enabled ;; restart'    )

c.colors.webpage.bg = "#2E3440"
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 100
c.colors.webpage.darkmode.policy.images = 'always'
c.colors.webpage.darkmode.grayscale.images = 0.35


# Bindings
config.bind(',d', 'set content.user_stylesheets ~/.config/qutebrowser/stylesheets/dark.css')
config.bind(',c', 'set content.user_stylesheets ~/.config/qutebrowser/stylesheets/sepia.css')
config.bind(',,', 'set content.user_stylesheets ""')
config.bind(',r', 'spawn --userscript readability')
# }}}
# {{{ Search Engines

# Search
c.url.searchengines["y"] = \
	"https://yewtu.be/search?q={}"

c.url.searchengines["Y"] = \
	"https://youtube.com/results?search_query={}"

c.url.searchengines['g'] = \
   'https://www.google.com/search?q={}'
 
c.url.searchengines['w'] = \
    'https://en.wikipedia.org/?search={}'

c.url.searchengines['x'] = \
    'https://1337x.unblockit.pet/search/{}/1/'

# Linguistic
c.url.searchengines['de'] = \
    'https://www.deepl.com/translator#en/de/{}'

c.url.searchengines['en'] = \
    'https://www.deepl.com/translator#de/en/{}'

c.url.searchengines['p'] = \
	'https://www.powerthesaurus.org/{}/synonyms'

c.url.searchengines['k'] = \
	'https://www.merriam-webster.com/dictionary/{}'

# }}}
# {{{ Adblocking
# Test Adblock: https://d3ward.github.io/toolz/adblock.html
c.content.blocking.method = "hosts"

# Enhance Privacy
# TEST: https://coveryourtracks.eff.org
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
]
# }}}
# {{{ Privacy

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "chrome-devtools://*")

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "devtools://*")

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String

# config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString

# Avoid Browser Deprecation Messages
# NEWEST: https://www.mozilla.org/en-US/firefox/releases/
# METHOD: Firefox > Help > About
config.set(
    "content.headers.user_agent",
    # 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}',
    "Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101 Firefox/108.0"
)


# Which method of blocking ads should be used.  Support for Adblock Plus
# (ABP) syntax blocklists using Brave's Rust library requires the
# `adblock` Python package to be installed, which is an optional
# dependency of qutebrowser. It is required when either `adblock` or
# `both` are selected.
# Type: String
# Valid values:
#   - auto: Use Brave's ABP-style adblocker if available, host blocking otherwise
#   - adblock: Use Brave's ABP-style adblocker
#   - hosts: Use hosts blocking
#   - both: Use both hosts blocking and Brave's ABP-style adblocker

# }}}
# {{{ Javascript & Notifications
# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome://*/*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.notifications.enabled", False, "https://www.reddit.com")

# }}}
# {{{ Colors
# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = "#d8dee9"

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = "#3b4252"

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = "#3b4252"

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = "#e5e9f0"

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = "#2e3440"

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = "#2e3440"

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = "#2e3440"

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = "#eceff4"

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = "#4c566a"

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = "#4c566a"

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = "#4c566a"

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = "#ebcb8b"

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = "#e5e9f0"

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = "#3b4252"

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = "#2e3440"

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = "#b48ead"

# Color gradient interpolation system for download backgrounds.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.downloads.system.bg = "none"

# Foreground color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.fg = "#e5e9f0"

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = "#bf616a"

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = "#E5E9F0"

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = "#2B5790"

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = "#EBCB8B"

# Text color for the keyhint widget.
# Type: QssColor
c.colors.keyhint.fg = "#e5e9f0"

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = "#ebcb8b"

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = "#3b4252"

# Foreground color of an error message.
# Type: QssColor
c.colors.messages.error.fg = "#e5e9f0"

# Background color of an error message.
# Type: QssColor
c.colors.messages.error.bg = "#bf616a"

# Border color of an error message.
# Type: QssColor
c.colors.messages.error.border = "#bf616a"

# Foreground color of a warning message.
# Type: QssColor
c.colors.messages.warning.fg = "#e5e9f0"

# Background color of a warning message.
# Type: QssColor
c.colors.messages.warning.bg = "#d08770"

# Border color of a warning message.
# Type: QssColor
c.colors.messages.warning.border = "#d08770"

# Foreground color of an info message.
# Type: QssColor
c.colors.messages.info.fg = "#e5e9f0"

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = "#3b4252"

# Border color of an info message.
# Type: QssColor
c.colors.messages.info.border = "#3b4252"

# Foreground color for prompts.
# Type: QssColor
c.colors.prompts.fg = "#e5e9f0"

# Border used around UI elements in prompts.
# Type: String
c.colors.prompts.border = "1px solid #2e3440"

# Background color for prompts.
# Type: QssColor
c.colors.prompts.bg = "#434c5e"

# Background color for the selected item in filename prompts.
# Type: QssColor
c.colors.prompts.selected.bg = "#4c566a"

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = "#e5e9f0"

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = "#2e3440"

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = "#3b4252"

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = "#a3be8c"

# Foreground color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.fg = "#e5e9f0"

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = "#5e81ac"

# Foreground color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.fg = "#e5e9f0"

# Background color of the statusbar in private browsing mode.
# Type: QssColor
c.colors.statusbar.private.bg = "#4c566a"

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = "#e5e9f0"

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = "#434c5e"

# Foreground color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.fg = "#e5e9f0"

# Background color of the statusbar in private browsing + command mode.
# Type: QssColor
c.colors.statusbar.command.private.bg = "#434c5e"

# Foreground color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.fg = "#e5e9f0"

# Background color of the statusbar in caret mode.
# Type: QssColor
c.colors.statusbar.caret.bg = "#b48ead"

# Foreground color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.fg = "#e5e9f0"

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = "#b48ead"

# Background color of the progress bar.
# Type: QssColor
c.colors.statusbar.progress.bg = "#e5e9f0"

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = "#e5e9f0"

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = "#bf616a"

# Foreground color of the URL in the statusbar for hovered links.
# Type: QssColor
c.colors.statusbar.url.hover.fg = "#88c0d0"

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = "#e5e9f0"

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = "#a3be8c"

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = "#d08770"

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = "#4c566a"

# Color for the tab indicator on errors.
# Type: QtColor
c.colors.tabs.indicator.error = "#bf616a"

# Color gradient interpolation system for the tab indicator.
# Type: ColorSystem
# Valid values:
#   - rgb: Interpolate in the RGB color system.
#   - hsv: Interpolate in the HSV color system.
#   - hsl: Interpolate in the HSL color system.
#   - none: Don't show a gradient.
c.colors.tabs.indicator.system = "none"

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = "#e5e9f0"

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = "#4c566a"

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = "#e5e9f0"

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = "#4c566a"

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = "#e5e9f0"

c.colors.tabs.pinned.even.bg = "#4c566a"
c.colors.tabs.pinned.odd.bg = "#4c566a"

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = "#2e3440"

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = "#e5e9f0"

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = "#2e3440"
# }}}
