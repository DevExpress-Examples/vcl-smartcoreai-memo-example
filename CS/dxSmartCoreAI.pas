unit dxSmartCoreAI;

interface

uses
  System.Threading, System.SyncObjs, System.Classes, System.SysUtils,
  dxAI, dxAI.Commands.Text,
  SmartCoreAI.Comp.Connection, SmartCoreAI.Types, SmartCoreAI.Comp.Chat;

type

  { TdxSmartCoreAIChatClient }

  TdxSmartCoreAIChatClient = class(TdxAIChatClient)
  private
    FConnection: TAIConnection;
    FRequest: TAIChatRequest;
    FResponseEvent: TEvent;
    FLastResponse: string;
    function ConvertResponse(const AResponseText: string): TdxAIChatResponse;
    function GetCombinedPrompt(const AMessages: IEnumerable<TdxAIChatMessage>): string;
    function PerformChatRequest(const AMessages: IEnumerable<TdxAIChatMessage>;
      const AOptions: TdxAIChatOptions): TdxAIChatResponse;
    procedure ResponseHandler(ASender: TObject; const AText: string);
  public
    constructor Create(ADriver: TAIDriver);
    destructor Destroy; override;
    function GetResponseAsync(const AMessages: IEnumerable<TdxAIChatMessage>; const AOptions: TdxAIChatOptions = nil;
      const ACancellationToken: TObject = nil): IFuture<TdxAIChatResponse>; override;
  end;

implementation

{ TdxSmartCoreAIChatClient }

constructor TdxSmartCoreAIChatClient.Create(ADriver: TAIDriver);
begin
  inherited Create;
  FConnection := TAIConnection.Create(nil);
  FRequest := TAIChatRequest.Create(nil);
  FResponseEvent := TEvent.Create;
  FRequest.OnResponse := ResponseHandler;
  FConnection.Driver := ADriver;
  FRequest.Connection := FConnection;
end;

destructor TdxSmartCoreAIChatClient.Destroy;
begin
  FResponseEvent.Free;
  FConnection.Free;
  FRequest.Free;
  inherited;
end;

function TdxSmartCoreAIChatClient.GetResponseAsync(const AMessages: IEnumerable<TdxAIChatMessage>;
  const AOptions: TdxAIChatOptions; const ACancellationToken: TObject): IFuture<TdxAIChatResponse>;
begin
  Result := TTask.Future<TdxAIChatResponse>(
    function: TdxAIChatResponse
    begin
      Result := PerformChatRequest(AMessages, AOptions);
    end);
end;

function TdxSmartCoreAIChatClient.ConvertResponse(const AResponseText: string): TdxAIChatResponse;
var
  AMessage: TdxAIChatMessage;
begin
  AMessage := TdxAIChatMessage.Create(TdxAIChatRole.Assistant, AResponseText);
  Result := TdxAIChatResponse.Create(AMessage, TdxAIChatFinishReason.Stop);
end;

function TdxSmartCoreAIChatClient.GetCombinedPrompt(const AMessages: IEnumerable<TdxAIChatMessage>): string;
var
  AMessage: TdxAIChatMessage;
  AStrings: TStrings;
begin
  Result := '';
  AStrings := TStringList.Create;
  try
    for AMessage in AMessages do
      AStrings.Add(AMessage.Text);
    Result := AStrings.Text;
  finally
    AStrings.Free;
  end;
end;

function TdxSmartCoreAIChatClient.PerformChatRequest(const AMessages: IEnumerable<TdxAIChatMessage>;
  const AOptions: TdxAIChatOptions): TdxAIChatResponse;
var
  ACombinedPrompt: string;
begin
  FResponseEvent.ResetEvent;
  ACombinedPrompt := GetCombinedPrompt(AMessages);
  FRequest.Chat(ACombinedPrompt);
  if FResponseEvent.WaitFor(60_000) <> wrTimeout then
    Result := ConvertResponse(FLastResponse)
  else
    raise Exception.Create('Timeout for a response from the model has been reached.');
end;

procedure TdxSmartCoreAIChatClient.ResponseHandler(ASender: TObject; const AText: string);
begin
  FLastResponse := AText;
  FResponseEvent.SetEvent;
end;

end.
