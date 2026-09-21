[Setup]
AppId=B9F6E402-0CAE-4045-BDE6-14BD6C39C4EA
AppVersion=1.12.2+27
AppName=Dark Tune
AppPublisher=anandnet
AppPublisherURL=https://github.com/anandnet/Harmony-Music
AppSupportURL=https://github.com/anandnet/Harmony-Music
AppUpdatesURL=https://github.com/anandnet/Harmony-Music
DefaultDirName={autopf}\darktune
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=darktune-1.12.2
Compression=lzma
SolidCompression=yes
SetupIconFile=..\..\windows\runner\resources\app_icon.ico
WizardStyle=modern
PrivilegesRequired=lowest
LicenseFile=..\..\LICENSE
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\build\windows\x64\runner\Release\darktune.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\Dark Tune"; Filename: "{app}\darktune.exe"
Name: "{autodesktop}\Dark Tune"; Filename: "{app}\darktune.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\darktune.exe"; Description: "{cm:LaunchProgram,{#StringChange('Dark Tune', '&', '&&')}}"; Flags: nowait postinstall skipifsilent
