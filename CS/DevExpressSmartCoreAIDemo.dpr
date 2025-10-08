program DevExpressSmartCoreAIDemo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {SmartCoreAIDemoMainForm},
  dxSmartCoreAI in 'dxSmartCoreAI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSmartCoreAIDemoMainForm, SmartCoreAIDemoMainForm);
  Application.Run;
end.
