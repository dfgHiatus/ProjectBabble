; Define our app's constants
#define MyAppName "Project Babble"
#define MyAppVersion "2.0.8a"
#define MyAppPublisher "The Project Babble Team"
#define MyAppURL "https://github.com/Project-Babble/ProjectBabble"
#define MyAppScript "babbleapp.py"
#define MyAppExeName "ProjectBabble.exe"

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

; relevant answers
; https://stackoverflow.com/a/77268297

; Make sure we can run powershell commands later on
PrivilegesRequiredOverridesAllowed=commandline

; How to package our app and other resources
OutputDir=..\installer\
OutputBaseFilename=Project Babble Setup
SetupIconFile=..\BabbleApp\Images\logo.ico
Compression=lzma/ultra64
SolidCompression=yes
WizardStyle=modern
ShowComponentSizes=no

; Set the installer language to English
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Components]
Name: "program"; Description: "Program Files"; Types: full compact custom; Flags: fixed
Name: "libs"; Description: "Hardware Acceleration"; Types: compact
Name: "libs/nvidia"; Description: "Nvidia"; Types: full
Name: "libs/directml"; Description: "DirectML"; Types: full

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
Source: "dummy1.txt"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; components: program; AfterInstall: InstallBaseDeps
Source: "dummy2.txt"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; components: libs/nvidia; AfterInstall: InstallNvidia
Source: "dummy3.txt"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; components: libs/directml; AfterInstall: InstallDirectML

; Set permissions
[Dirs]
Name: {app}; Permissions: users-full

; Set desktop/taskbar icons
[Icons]
Name: "{autoprograms}\{#MyAppName}"; WorkingDir: "{app}"; Parameters: "babbleapp.py"; Filename: "{app}\bin\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; WorkingDir: "{app}"; Parameters: "babbleapp.py"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon

; Run!
[Run]
Filename: "{app}\bin\{#MyAppExeName}"; WorkingDir: "{app}"; Parameters: "babbleapp.py"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent



[Code]
function InstallDep(const dep : string; const text: string): Boolean;       
var 
  ResultCode: Integer;
  StatusText: string;
begin
  WizardForm.StatusLabel.Caption := 'Installing python library ' + text + ': ' + dep + '...';
  Exec('cmd', '/c .\bin\python.exe -m pip install ' + dep, ExpandConstant('{app}'), SW_HIDE, ewWaitUntilTerminated, ResultCode);
end;

procedure InstallBaseDeps;
begin
  WizardForm.ProgressGauge.Style := npbstMarquee;
  InstallDep('onnxruntime==1.19.2', '(Base 1/16)');
  InstallDep('opencv_python==4.11.0.86', '(Base 2/16)');
  InstallDep('pillow==11.0.0', '(Base 3/16)');
  InstallDep('FreeSimpleGUI==5.1.1', '(Base 4/16)');
  InstallDep('python_osc==1.9.0', '(Base 5/16)');
  InstallDep('pydantic==2.10.6', '(Base 6/16)');
  InstallDep('pyserial==3.5', '(Base 7/16)');
  InstallDep('colorama==0.4.6', '(Base 8/16)');
  InstallDep('desktop-notifier==6.0.0', '(Base 9/16)');
  InstallDep('comtypes==1.4.8', '(Base 10/16)'); 
  InstallDep('pygrabber==0.2', '(Base 11/16)');
  InstallDep('psutil==7.0.0', '(Base 12/16)');
  InstallDep('requests==2.32.3', '(Base 13/16)');
  InstallDep('v4l2py==3.0.0', '(Base 14/16)');
  InstallDep('sounddevice==0.5.1', '(Base 15/16)');
  InstallDep('soundfile==0.13.1', '(Base 16/16)');
end;

procedure InstallNvidia;
begin
  WizardForm.ProgressGauge.Style := npbstMarquee;
  InstallDep('torch==2.6.0', '(Nvidia 1/2)');
  InstallDep('torchvision==0.21.0', '(Nvidia 2/2)');
end;

procedure InstallDirectML;
begin
  WizardForm.ProgressGauge.Style := npbstMarquee;
  InstallDep('onnxruntime-directml==1.19.2', '(DirectML 1/1)');
end;

