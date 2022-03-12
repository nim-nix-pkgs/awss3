{
  description = ''Amazon Simple Storage Service (AWS S3) basic API support.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-awsS3-v1_0_0.flake = false;
  inputs.src-awsS3-v1_0_0.owner = "ThomasTJdev";
  inputs.src-awsS3-v1_0_0.ref   = "refs/tags/v1.0.0";
  inputs.src-awsS3-v1_0_0.repo  = "nim_awsS3";
  inputs.src-awsS3-v1_0_0.type  = "github";
  
  inputs."sigv4".dir   = "nimpkgs/s/sigv4";
  inputs."sigv4".owner = "riinr";
  inputs."sigv4".ref   = "flake-pinning";
  inputs."sigv4".repo  = "flake-nimble";
  inputs."sigv4".type  = "github";
  inputs."sigv4".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sigv4".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."awssts".dir   = "nimpkgs/a/awssts";
  inputs."awssts".owner = "riinr";
  inputs."awssts".ref   = "flake-pinning";
  inputs."awssts".repo  = "flake-nimble";
  inputs."awssts".type  = "github";
  inputs."awssts".inputs.nixpkgs.follows = "nixpkgs";
  inputs."awssts".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-awsS3-v1_0_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-awsS3-v1_0_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}