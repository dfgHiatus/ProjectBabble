; Define our app's constants
#define MyAppName "Project Babble"
#define MyAppVersion "2.0.8a"
#define MyAppPublisher "The Project Babble Team"
#define MyAppURL "https://github.com/Project-Babble/ProjectBabble"
#define MyAppScript "babbleapp.py"
#define MyAppExeName "run_project_babble.ps1"

; Boilerplate
[Setup]
AppId={{CE6A1AB3-F0E8-4799-B25A-F925536ACB50}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes

; Make sure we can run powershell commands later on
PrivilegesRequiredOverridesAllowed=commandline

; How to package our app and other resources
OutputDir=bin
OutputBaseFilename=Project Babble Setup
SetupIconFile=..\BabbleApp\Images\logo.ico
Compression=lzma/ultra64
SolidCompression=yes
WizardStyle=modern

; Set the installer language to English
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Desktop Icon Shortcut
; This shows up as a checkbox!
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

; Reset the user's settings. Do this even if they already have an existing install!
[InstallDelete]
Type: files; Name: "{app}\babble_settings.json"

; Extract our files, and download the drivers
; NUKE THE VENV FOLDER BEFOREHAND OR THE INSTALLER WILL BE 2 GB IN SIZE
[Files]
Source: "*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "install_dependencies.ps1"; DestDir: "{app}"

; Set permissions
[Dirs]
Name: {app}; Permissions: users-full

; Set desktop/taskbar icons
[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

; Run!
[Run]
Filename: "powershell.exe"; \
  Parameters: "-ExecutionPolicy Bypass -File ""install_dependencies.ps1"""; \
  WorkingDir: {app};
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent;

;pip install goodness
; [Code]
// procedure InstallRequirements;
// var
  // ResultCode: Integer;
  // StatusText: string;
// begin
  // StatusText := WizardForm.StatusLabel.Caption;
  // WizardForm.StatusLabel.Caption := 'Installing dependencies(s)...';
  // WizardForm.ProgressGauge.Style := npbstMarquee;
  // try 
    // if not Exec(
      // 'powershell', 
      // '-noexit -nologo -executionpolicy bypass -File ' + ExpandConstant('{app}\install_dependencies.ps1'),
      // '',
      // SW_SHOW, 
      // ewWaitUntilTerminated, 
      // ResultCode) then
    // begin
      // MsgBox('Dependency installation failed with code: ' + IntToStr(ResultCode) + '.', mbError, MB_OK);
    // end;
  // finally
    // WizardForm.StatusLabel.Caption := StatusText;
    // WizardForm.ProgressGauge.Style := npbstNormal;
  // end;
// end;