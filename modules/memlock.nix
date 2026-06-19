{ self, inputs, ... }: {

 flake.nixosModules.memlock = { config, pkgs, ... }: {   


  # ====== Memlock Limits ======
    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
    ];
 };
}
