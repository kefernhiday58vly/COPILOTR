{
  "name": "XMR Miner Auto Start",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",

  // Tự động cấp quyền và chạy file mine_xmr.sh khi Codespace khởi động
  "postAttachCommand": "chmod +x ~/mine_xmr.sh && bash ~/mine_xmr.sh",

  "forwardPorts": [8080],   // Mở port HTTP của XMRig để theo dõi
  "portsAttributes": {
    "8080": {
      "label": "XMRig Dashboard",
      "onAutoForward": "openPreview"
    }
  },

  "customizations": {
    "vscode": {
      "extensions": [
        "github.copilot",
        "github.copilot-chat"
      ]
    }
  },

  "waitFor": "onPostAttachCommand"
}
