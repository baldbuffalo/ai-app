using System.Text.Json;
using System.Windows;

namespace AiApp.Windows
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Init();
        }

        private async void Init()
        {
            await Web.EnsureCoreWebView2Async();
            Web.CoreWebView2.Navigate("https://claude.ai");
        }

        private async void SendBtn_Click(object sender, RoutedEventArgs e)
        {
            var p = JsonSerializer.Serialize(InputBox.Text);
            var js = $@"(function(p){{
              const ed = document.querySelector('div[contenteditable=""true""]');
              if(!ed){{return 'no-editor';}}
              ed.focus();
              document.execCommand('insertText', false, p);
              const btn = document.querySelector('button[aria-label=""Send message""]');
              if(btn){{btn.click(); return 'sent';}}
              ed.dispatchEvent(new KeyboardEvent('keydown',{{key:'Enter',bubbles:true}}));
              return 'sent-enter';
            }})({p});";
            StatusText.Text = await Web.CoreWebView2.ExecuteScriptAsync(js);
            InputBox.Text = "";
        }
    }
}
