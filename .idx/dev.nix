{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  services.docker.enable = true;
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python3
    pkgs.python311Packages.pip
    pkgs.python311Packages.fastapi
    pkgs.python311Packages.uvicorn
    pkgs.docker-compose
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [ 
      "ms-python.python"
      "ms-python.debugpy"
      "rangav.vscode-thunder-client"  
      "humao.rest-client" 
      "ms-azuretools.vscode-docker"];
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["./devserver.sh"];
          manager = "web";
        };
      };
    };
    
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        create-venv = ''
          python -m venv .venv
          source .venv/bin/activate
          pip install -r requirements.txt
        '';
      };
      
      # To run something each time the workspace is (re)started, use the `onStart` hook
      #onStart = { run-server = "./devserver.sh"; };
    };
  };
}
