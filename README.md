<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/1000886390/25.1.3%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T1296609)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
[![](https://img.shields.io/badge/💬_Leave_Feedback-feecdd?style=flat-square)](#does-this-example-address-your-development-requirementsobjectives)
<!-- default badges end -->
# DevExpress VCL/Delphi - Integrate SmartCore AI component library 

This simple example integrates AI into DevExpress VCL Controls using the official Embarcader SmartCore AI component library available via the GetIt Package Manager.
VCL developers can switch between different AI providers and utilize commands that DevExpress AI Assistant adds to DevExpress Text Editors (such as `TcxMemo` or `TdxRichEditControl`).

![DevExpress VCL AI Example](./Images/vcl-text-editor-ai-demo.gif)

> [!NOTE]
> VCL developers can use either SmartCore AI library, plug in third-party libraries or leverage own implementation to support different AI providers. For example, the DevExpress VCL Rich Text Editor demo ("%Public%\DevExpress VCL Demos\MegaDemos\Product Demos\ExpressRichEditControl\dxAI.ChatClient.Azure.pas" uses our Azure OpenAI service deployment via a simple `TdxAIAzureChatClient` implementation (extends our base `TdxAIChatClient` API).

<Screenshot or video goes here>

 ## Prerequisites

 - Microsoft Windows 10 or newer
 - Embarcadero RAD Studio IDE 13.0 or newer (Community Edition is not supported)
 - The [SmartCore AI Components](https://blogs.embarcadero.com/introducing-the-smartcore-ai-components-pack/) package installed from GetIt
 - DevExpress VCL Components v25.1.3 or newer

## Running the example

To connect to an AI provider open the main form in designer, open editor for your driver of choice (OpenAI or Google Gemini in this example) and fill in API key. Then uncomment the `TdxSmartCoreAIChatClient.Create` call for the required AI provider`:

```
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

```

> [!NOTE]
> DevExpress AI-powered Extensions follow the "bring your own key" principle. DevExpress does not offer a REST API and does not ship any built-in LLMs/SLMs. You need an active subscription for the required AI service to obtain the REST API endpoint, key, and model deployment name. These variables must be specified at application startup to register AI clients and enable DevExpress AI-powered Extensions in your application.

<!-- feedback -->
## Does this example address your development requirements/objectives?

[<img src="https://www.devexpress.com/support/examples/i/yes-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=vcl-ai-memo-example&~~~was_helpful=yes) [<img src="https://www.devexpress.com/support/examples/i/no-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=vcl-ai-memo-example&~~~was_helpful=no)

(you will be redirected to DevExpress.com to submit your response)
<!-- feedback end -->
