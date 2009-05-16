// CHANGE FOR APPS HOSTED IN SUBDIRECTORY
FCKRelativePath = '';

// DON'T CHANGE THESE
FCKConfig.LinkBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Connector='+FCKRelativePath+'/fckeditor/command';
FCKConfig.ImageBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Image&Connector='+FCKRelativePath+'/fckeditor/command';
FCKConfig.FlashBrowserURL = FCKConfig.BasePath + 'filemanager/browser/default/browser.html?Type=Flash&Connector='+FCKRelativePath+'/fckeditor/command';

FCKConfig.LinkUploadURL = FCKRelativePath+'/fckeditor/upload';
FCKConfig.ImageUploadURL = FCKRelativePath+'/fckeditor/upload?Type=Image';
FCKConfig.FlashUploadURL = FCKRelativePath+'/fckeditor/upload?Type=Flash';
FCKConfig.SpellerPagesServerScript = FCKRelativePath+'/fckeditor/check_spelling';

FCKConfig.ImageUpload = false;
FCKConfig.ImageBrowser = true;
FCKConfig.ImageDlgHideLink = true;

FCKConfig.FlashUpload = false;
FCKConfig.FlashBrowser = true;

FCKConfig.LinkUpload = false;
FCKConfig.LinkBrowser = true;

FCKConfig.ForcePasteAsPlainText = true;
FCKConfig.StartupShowBlocks = false;
FCKConfig.FormatIndentator = '\t';
FCKConfig.TabSpaces = 2;
FCKConfig.ToolbarCanCollapse = false;
FCKConfig.FirefoxSpellChecker = true;
FCKConfig.AllowQueryStringDebug = false;
FCKConfig.SpellChecker = 'SpellerPages';

// ONLY CHANGE BELOW HERE
FCKConfig.SkinPath = FCKConfig.BasePath + 'skins/default/';

FCKConfig.ToolbarSets["Default"] = [
	['FontFormat','Bold','Italic','Underline','-','OrderedList','UnorderedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyFull','-','Link','Unlink','Anchor','-','Image','Flash','Table','Rule','-','SelectAll','RemoveFormat', 'ShowBlocks', 'Source']
];

/*
FCKConfig.ToolbarSets["Default"] = [
['Source','DocProps','-','Save','NewPage','Preview','-','Templates'],
['Cut','Copy','Paste','PasteText','PasteWord','-','Print','SpellCheck'],
['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
['Form','Checkbox','Radio','TextField','Textarea','Select','Button','ImageButton','HiddenField'],
'/',
['Bold','Italic','Underline','StrikeThrough','-','Subscript','Superscript'],
['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote'],
['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
['Link','Unlink','Anchor'],
['Image','Flash','Table','Rule','Smiley','SpecialChar','PageBreak'],
'/',
['Style','FontFormat','FontName','FontSize'],
['TextColor','BGColor'],
['FitWindow','ShowBlocks','-','About'] // No comma for the last row.
];
*/
