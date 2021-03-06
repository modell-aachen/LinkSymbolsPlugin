# ---+ Extensions
# ---++ LinkSymbolsPlugin

# **STRING**
# jQuery selector for the elements where the links reside (exclude your editor here!).
# <p>Please escape apostrophes.</p>
$Foswiki::cfg{LinkSymbolPlugin}{selector} = 'div.foswikiTopic a:not(div.patternEditTopic a, div.solrSearchHits a, .SearchGridContainer a)';

# **STRING 80x15**
# Javascript object with a mapping from web-regexes to their image.
$Foswiki::cfg{LinkSymbolPlugin}{webmapping} = "{
}";

# **STRING 80x15**
# Javascript object with a mapping from extension-regexes to their image.
$Foswiki::cfg{LinkSymbolPlugin}{mapping} = "{
'gif|bmp|png|tiff|svg|jpe?g':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/photo.png',
'pdf':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/page_white_acrobat.png',
'docx?|docm|dotx?|odt|rtf':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/page_white_word.png',
'pptx?':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/page_white_powerpoint.png',
'xlsx?|xlsm|ods':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/page_white_excel.png',
'txt':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/page_white.png',
'zip|rar':'%PUBURLPATH%/%SYSTEMWEB%/FamFamFamSilkIcons/compress.png'
}";

# **STRING**
# html to append to the link - placeholder for the image is $IMAGE
# <p>Please escape apostrophes.</p>
$Foswiki::cfg{LinkSymbolPlugin}{append} = '<span class="foswikiIcon" style="white-space:nowrap; margin-left:3px;"><img width="16" height="16" src="$IMAGE" /></span>';

# **STRING**
# html to prepend to the link - placeholder for the image is $IMAGE
# <p>Please escape apostrophes.</p>
$Foswiki::cfg{LinkSymbolPlugin}{prepend} = '';
