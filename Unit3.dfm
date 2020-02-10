object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 82
    Width = 635
    Height = 217
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 558
      Height = 39
      Align = alClient
      Caption = 'Label1'
      ExplicitWidth = 31
      ExplicitHeight = 13
    end
    object Button2: TButton
      Left = 559
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = #25509#32154
      TabOrder = 0
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 2
    object Edit1: TEdit
      Left = 1
      Top = 1
      Width = 558
      Height = 39
      Align = alClient
      TabOrder = 0
      Text = 'Edit1'
      ExplicitHeight = 21
    end
    object Button1: TButton
      Left = 559
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = #36865#20449
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object IdUDPServer1: TIdUDPServer
    BroadcastEnabled = True
    Bindings = <
      item
        IP = '127.0.0.1'
        Port = 80
      end>
    DefaultPort = 80
    OnUDPRead = IdUDPServer1UDPRead
    Left = 528
    Top = 96
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <
      item
        IP = '127.0.0.1'
        Port = 80
      end>
    DefaultPort = 80
    OnExecute = IdTCPServer1Execute
    Left = 528
    Top = 160
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 400
    Top = 168
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 400
    Top = 120
  end
end
