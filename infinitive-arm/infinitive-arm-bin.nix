{ stdenv, lib, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "infinitive-arm-bin";
  version = "0.2";

  src = fetchurl {
    url = "https://github.com/acd/infinitive/releases/download/v${version}/infinitive.arm";
    sha256 = "0icr8796frm1rkzq0j66jpg307cid29060pns83iakza2vscgpbc";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  sourceRoot = ".";

  installPhase = ''
install -m755 -D $src $out/bin/infinitive
'';

  meta = with lib; {
    homepage = "https://github.com/acd/infinitive";
    description = "Carrier Infinity SAM server";
    platforms = platforms.linux;
  };
}
