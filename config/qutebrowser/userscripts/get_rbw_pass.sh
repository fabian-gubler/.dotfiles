#!/bin/sh

[[ "$QUTE_URL" =~ https?:\/\/([^/]*?\.)?([^/.]+)\.[^/.]+ ]] 
BASE_URL="${BASH_REMATCH[2]}" # "google" from "https://accounts.google.com/help"

if PASS=$(rbw get "$BASE_URL" 2>&1 );
then
    # No error getting password: copy password to clipboard and then get TOTP (or clear)
    TOTP=$(rbw code "$BASE_URL" 2>/dev/null) 
    USER="$(rbw get --full "$BASE_URL" | sed -n '2 p' | awk  '{print $2}')"
else
    # Error getting password (multiple choices): parse error and select entry with dmenu
    [[ "$PASS" =~ multiple\ entries\ found:\ (.*) ]] 
    ENTRIES="${BASH_REMATCH[1]}" # "name1@google.com, name2@google.com, name3@google.com"
    SELECTED_ENTRY=$(echo "$ENTRIES" | tr ',' '\n' | dmenu -i)
    [[ "$SELECTED_ENTRY" =~ (.*)@[^@]* ]]  
    SELECTED_ENTRY=$(echo "${BASH_REMATCH[1]}" | xargs) # "name1" in " name1@google.com

    PASS=$(rbw get "$BASE_URL" "$SELECTED_ENTRY");
    TOTP=$(rbw code "$BASE_URL" "$SELECTED_ENTRY" 2>/dev/null) 
    USER="$(rbw get --full "$BASE_URL" "$SELECTED_ENTRY" | sed -n '2 p' | awk  '{print $2}')"
fi

javascript_escape() {
    # print the first argument in an escaped way, such that it can safely
    # be used within javascripts double quotes
    # shellcheck disable=SC2001
    sed "s,[\\\\'\"],\\\\&,g" <<< "$1"
}

js() {
cat <<EOF
    function isVisible(elem) {
        var style = elem.ownerDocument.defaultView.getComputedStyle(elem, null);
        if (style.getPropertyValue("visibility") !== "visible" ||
            style.getPropertyValue("display") === "none" ||
            style.getPropertyValue("opacity") === "0") {
            return false;
        }
        return elem.offsetWidth > 0 && elem.offsetHeight > 0;
    };
    function hasPasswordField(form) {
        var inputs = form.getElementsByTagName("input");
        for (var j = 0; j < inputs.length; j++) {
            var input = inputs[j];
            if (input.type == "password") {
                return true;
            }
        }
        return false;
    };
    function loadData2Form (form) {
        var inputs = form.getElementsByTagName("input");
        for (var j = 0; j < inputs.length; j++) {
            var input = inputs[j];
            if (isVisible(input) && (input.type == "text" || input.type == "email")) {
                input.focus();
                input.value = "$(javascript_escape "${USER}")";
                input.dispatchEvent(new Event('change'));
                input.blur();
            }
            if (input.type == "password") {
                input.focus();
                input.value = "$(javascript_escape "${PASS}")";
                input.dispatchEvent(new Event('change'));
                input.blur();
            }
        }
    };
    var forms = document.getElementsByTagName("form");
    for (i = 0; i < forms.length; i++) {
        if (hasPasswordField(forms[i])) {
            loadData2Form(forms[i]);
        }
    }
EOF
}

printjs() {
    js | sed 's,//.*$,,' | tr '\n' ' '
}
echo "jseval -q $(printjs)" >> "$QUTE_FIFO"
echo "$PASS" | xclip -selection clipboard 
((sleep 4; echo "$TOTP" |  xclip -selection clipboard) &) 

