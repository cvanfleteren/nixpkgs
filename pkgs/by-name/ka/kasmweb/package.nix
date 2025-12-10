{
  stdenv,
  lib,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "kasmweb";
  version = "1.18.1";

  src = fetchzip {
    url = "https://kasm-static-content.s3.amazonaws.com/kasm_release_${version}.tar.gz";
    sha256 = "sha256-7z5lc4QEpQQdVGMEMc04wXlJTK5VXJ4rufZmDEflJLw=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    rm bin/utils/yq*
    cp -r bin conf www $out/

    runHook postInstall
  '';

  meta = {
    homepage = "https://www.kasmweb.com/";
    description = "Streaming containerized apps and desktops to end-users";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ s1341 ];
  };
}
