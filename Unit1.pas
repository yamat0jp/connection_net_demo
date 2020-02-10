unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, FMX.Controls.Presentation, FMX.Edit, System.Tether.Manager,
  System.Tether.AppProfile, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    Panel2: TPanel;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    { private éŒ¾ }
  public
    { public éŒ¾ }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}
{$R *.Windows.fmx MSWINDOWS}

procedure TForm1.Button1Click(Sender: TObject);
begin
  TetheringManager1.AutoConnect;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  s: TTetheringProfileInfo;
begin
  for s in TetheringManager1.RemoteProfiles do
    if (s.ProfileGroup = 'sampleChatGroup') and
      (s.ProfileText = 'sampleChatProfile') then
      TetheringAppProfile1.SendString(s, 'ƒRƒƒ“ƒg', Edit1.Text);
end;

procedure TForm1.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  TThread.Synchronize(nil,procedure
    begin
      ListBox1.Items.Add(AResource.Value.AsString);
    end);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if TetheringManager1.RemoteProfiles.Count > 0 then
    Label1.Text := 'Ú‘±’†'
  else
    Label1.Text := 'Ú‘±‚µ‚Ä‚¢‚Ü‚¹‚ñ';
end;

end.
