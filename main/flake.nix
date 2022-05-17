{
  description = ''Amazon S3 REST API (basic)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-awsS3-main.flake = false;
  inputs.src-awsS3-main.ref   = "refs/heads/main";
  inputs.src-awsS3-main.owner = "ThomasTJdev";
  inputs.src-awsS3-main.repo  = "nim_awsS3";
  inputs.src-awsS3-main.type  = "github";
  
  inputs."sigv4".owner = "nim-nix-pkgs";
  inputs."sigv4".ref   = "master";
  inputs."sigv4".repo  = "sigv4";
  inputs."sigv4".dir   = "1_2_1";
  inputs."sigv4".type  = "github";
  inputs."sigv4".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sigv4".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."awssts".owner = "nim-nix-pkgs";
  inputs."awssts".ref   = "master";
  inputs."awssts".repo  = "awssts";
  inputs."awssts".dir   = "v1_0_3";
  inputs."awssts".type  = "github";
  inputs."awssts".inputs.nixpkgs.follows = "nixpkgs";
  inputs."awssts".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-awsS3-main"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-awsS3-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}