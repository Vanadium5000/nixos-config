{
  lib,
  python3Packages,
  fetchFromGitHub,
  ...
}:
python3Packages.buildPythonApplication rec {
  pname = "Mopidy-Tidal";
  version = "0.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "caelestia-dots";
    repo = "cli";
    rev = "e691dfb7fc78223456a67763ee84489c414e93af";
    hash = "sha256-r7QovDn84mdUntl4gGPAhpcn/vZB5tpPWKSNBczThRQ=";
  };

  build-system = [python3Packages.poetry-core];

  dependencies = [];

  nativeCheckInputs = with python3Packages; [
    pytestCheckHook
    pytest-mock
  ];

  pytestFlagsArray = ["tests/"];

  meta = {
    description = "A collection of scripts for my caelestia dotfiles";
    homepage = "https://github.com/caelestia-dots/cli";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
