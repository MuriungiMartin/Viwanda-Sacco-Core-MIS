controladdin "MpesaAddin"
{

    MaximumHeight = 300;
    VerticalShrink = true;
    VerticalStretch = true;
    HorizontalShrink = true;
    HorizontalStretch = true;
    // RequestedHeight = 500;
    StyleSheets = 'stylesheet.css';

    Scripts = 'mpesascript.js';
    StartupScript = 'mpesastartup.js';
    event ControlReady()

    procedure pay()
}