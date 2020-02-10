unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer, IdGlobal, IdSocketHandle,
  IdBaseComponent, IdComponent, IdUDPBase, Vcl.StdCtrls, IdContext,
  IdCustomTCPServer, IdTCPServer, IdTCPConnection, IdTCPClient, Vcl.ExtCtrls;

type
  TMode = (cmServer, cmFindingServer, cmClient);

  TForm3 = class(TForm)
    IdUDPServer1: TIdUDPServer;
    IdTCPServer1: TIdTCPServer;
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Button1Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
    mode: TMode;
    procedure broadcastMessage(str: string);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.broadcastMessage(str: string);
var
  i: integer;
  s: TIdContext;
begin
  with IdTCPServer1.Contexts.LockList do
    for i := 0 to Count-1 do
    begin
      s:=Items[i];
      s.Connection.IOHandler.Write(str);
    end;
  IdTCPServer1.Contexts.UnlockList;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if mode = TMode.cmClient then
    IdTCPClient1.IOHandler.Write(Edit1.Text)
  else
    broadcastMessage(Edit1.Text);
//  ListBox1.Items.Insert(0, Edit1.Text);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  IdUDPServer1.Broadcast('サーバーある？', IdUDPServer1.DefaultPort);
  mode := TMode.cmFindingServer;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  IdUDPServer1.Active := false;
  IdTCPServer1.Active := false;
end;

procedure TForm3.IdTCPServer1Execute(AContext: TIdContext);
var
  s: string;
begin
  s := AContext.Connection.IOHandler.ReadLn(#13#10);
  ListBox1.Items.Insert(0, s);
  broadcastMessage(s);
end;

procedure TForm3.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  s: string;
  ip: string;
begin
  s := string(AData);
  ip := ABinding.PeerIP;
  if s = 'サーバーある？' then
  begin
    mode := TMode.cmServer;
    s := '私はサーバー';
    IdUDPServer1.Send(ip, IdUDPServer1.DefaultPort, s);
  end
  else if s = '私はサーバー' then
  begin
    mode := TMode.cmClient;
    IdTCPClient1.Host := ip;
    IdTCPClient1.Connect;
  end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  if mode <> TMode.cmFindingServer then
  begin
    Label1.Caption := '接続';
    Exit;
  end
  else
    Label1.Caption := '接続していません';
  mode := TMode.cmServer;
  IdTCPServer1.Active := true;
end;

end.
