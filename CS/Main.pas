unit Main;

interface

uses
  cxControls, Vcl.Forms, Vcl.Controls, cxTextEdit, cxMemo, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, System.Classes, dxAI, SmartCoreAI.Types, SmartCoreAI.Driver.OpenAI, SmartCoreAI.Driver.Gemini,
  dxSmartCoreAI;

type
  TSmartCoreAIDemoMainForm = class(TForm)
    cxMemo: TcxMemo;
    OpenAIDriver: TAIOpenAIDriver;
    GeminiDriver: TAIGeminiDriver;
    procedure FormCreate(Sender: TObject);
  end;

var
  SmartCoreAIDemoMainForm: TSmartCoreAIDemoMainForm;

implementation

{$R *.dfm}

procedure TSmartCoreAIDemoMainForm.FormCreate(Sender: TObject);
var
  Client: TdxAIChatClient;
begin
  // OpenAI
  // Client := TdxSmartCoreAIChatClient.Create(OpenAIDriver);

  // Google Gemini
  // Client := TdxSmartCoreAIChatClient.Create(GeminiDriver);

  TdxAIChatClients.AddChatClient(Client);
end;

end.
