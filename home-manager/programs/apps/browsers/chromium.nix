{ ... }:
{
  programs.chromium = {
    enable = true;
    extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "aapbdbdomjkkjkaonfhkkikfgjllcleb" # google translate
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
      "nngceckbapebfimnlniiiahkandclblb" # google translate
    ];
  };
}
