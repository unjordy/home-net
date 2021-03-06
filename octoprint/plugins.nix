{ pkgs }:

with pkgs;

self: super: let
  buildPlugin = args: self.buildPythonPackage (args // {
    pname = "OctoPrintPlugin-${args.pname}";
    inherit (args) version;
    propagatedBuildInputs = (args.propagatedBuildInputs or []) ++ [ super.octoprint ];
    # none of the following have tests
    doCheck = false;
  });
in {
  inherit buildPlugin;

  tplinksmartplug = buildPlugin rec {
    pname = "tplinksmartplug";
    version = "1.0.1";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-TPLinkSmartplug";
      rev = "${version}";
      sha256 = "022p52aipc9gnmfpg7pblmqvq58brgssxihyw0g11ijsz54n5mzk";
    };

    propagatedBuildInputs = with super; [ uptime ];
  };

  octopod = buildPlugin rec {
    pname = "octopod";
    version = "0.3.2";

    src = fetchFromGitHub {
      owner = "gdombiak";
      repo = "OctoPrint-OctoPod";
      rev = "${version}";
      sha256 = "00brp4wa2248aw0z3vgc6hf9l7kw34nrx5hkaynnhapyd7v9zk7g";
    };

    propagatedBuildInputs = with super; [ pillow ];
  };

  crealitytemperature = buildPlugin rec {
    pname = "crealitytemperature";
    version = "1.2.4";

    src = fetchFromGitHub {
      owner = "RomainOdeval";
      repo = "OctoPrint-CrealityTemperature";
      rev = "v${version}";
      sha256 = "1vscdsbkhjazlbyxn42gvd0np1nhn2xhnfmb1f49bq4m5ivs2xga";
    };
  };

  bltouch = buildPlugin rec {
    pname = "bltouch";
    version = "0.3.4";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-Bltouch";
      rev = "${version}";
      sha256 = "0w1ahkd7hf4ljlzjgb9qfirx2inrf8gi07i3kk76dzxsdjm4j1vx";
    };
  };

  m73progress = buildPlugin rec {
    pname = "m73progress";
    version = "0.2.1";

    src = fetchFromGitHub {
      owner = "cesarvandevelde";
      repo = "OctoPrint-M73Progress";
      rev = "v${version}";
      sha256 = "0bgmvddzr3yjbr6wv6hng9hsk3q46lsmipplf48bcaw6c608lq1d";
    };
  };

  ender3v2tempfix = buildPlugin rec {
    pname = "ender3v2tempfix";
    version = "0.0.4";

    src = fetchFromGitHub {
      owner = "SimplyPrint";
      repo = "OctoPrint-Creality2xTemperatureReportingFix";
      rev = "${version}";
      sha256 = "1qigzh3h4n8jh78ac9f9r5f31k0ri156nh2lrgpf9j35idd5cx6p";
    };
  };

  m86motorsoff = buildPlugin rec {
    pname = "M84MotorsOff";
    version = "0.1.0";

    src = fetchFromGitHub {
      owner = "ntoff";
      repo = "Octoprint-M84MotOff";
      rev = "v${version}";
      sha256 = "1w6h4hia286lbz2gy33rslq02iypx067yqn413xcipb07ivhvdq7";
    };

    meta = with lib; {
      description = "Changes the \"Motors off\" button in octoprint's control tab to issue an M84 command to allow compatibility with Repetier firmware Resources";
      homepage = "https://github.com/ntoff/OctoPrint-M84MotOff";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  abl-expert = buildPlugin rec {
    pname = "ABL_Expert";
    version = "0.6";

    src = fetchgit {
      url = "https://framagit.org/razer/Octoprint_ABL_Expert/";
      rev = version;
      sha256 = "0ij3rvdwya1sbymwm5swlh2j4jagb6fal945g88zrzh5xf26hzjh";
    };

    meta = with lib; {
      description = "Marlin auto bed leveling control, mesh correction, and z probe handling";
      homepage = "https://framagit.org/razer/Octoprint_ABL_Expert/";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  bedlevelvisualizer = buildPlugin rec {
    pname = "BedLevelVisualizer";
    version = "0.1.15";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1bq39fnarnpk8phxfbpx6l4n9anf358z1cgid5r89nadmn2a0cny";
    };

    propagatedBuildInputs = with super; [ numpy ];

    meta = with lib; {
      description = "Displays 3D mesh of bed topography report";
      homepage = "https://github.com/jneilliii/OctoPrint-BedLevelVisualizer";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  costestimation = buildPlugin rec {
    pname = "CostEstimation";
    version = "3.2.0";

    src = fetchFromGitHub {
      owner = "OllisGit";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1j476jcw7gh8zqqdc5vddwv5wpjns7cd1hhpn7m9fxq3d5bi077w";
    };

    meta = with lib; {
      description = "Plugin to display the estimated print cost for the loaded model.";
      homepage = "https://github.com/malnvenshorn/OctoPrint-CostEstimation";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  curaenginelegacy = buildPlugin rec {
    pname = "CuraEngineLegacy";
    version = "1.1.1";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1a7pxlmj1a7blkv97sn1k390pbjcxx2860011pbjcdnli74zpvv5";
    };

    meta = with lib; {
      description = "Plugin for slicing via Cura Legacy from within OctoPrint";
      homepage = "https://github.com/OctoPrint/OctoPrint-CuraEngineLegacy";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  displayprogress = buildPlugin rec {
    pname = "DisplayProgress";
    version = "0.1.3";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "080prvfwggl4vkzyi369vxh1n8231hrl8a44f399laqah3dn5qw4";
    };

    meta = with lib; {
      description = "Displays the job progress on the printer's display";
      homepage = "https://github.com/OctoPrint/OctoPrint-DisplayProgress";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  displaylayerprogress = buildPlugin rec {
    pname = "OctoPrint-DisplayLayerProgress";
    version = "1.24.0";

    src = fetchFromGitHub {
      owner = "OllisGit";
      repo = pname;
      rev = version;
      sha256 = "1lbivg3rcjzv8zqvp8n8gcaczxdm7gvd5ihjb6jq0fgf958lv59n";
    };

    meta = with lib; {
      description = "OctoPrint-Plugin that sends the current progress of a print via M117 command";
      homepage = "https://github.com/OllisGit/OctoPrint-DisplayLayerProgress";
      license = licenses.agpl3;
      maintainers = with maintainers; [ j0hax ];
    };
  };

  gcodeeditor = buildPlugin rec {
    pname = "GcodeEditor";
    version = "0.2.9";

    src = fetchFromGitHub {
      owner = "ieatacid";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1yjj9lmxbzmzrn7gahw9lj7554fphalbjjp8ns0rr9py3rshwxkm";
    };

    meta = with lib; {
      description = "Edit gcode on OctoPrint";
      homepage = "https://github.com/ieatacid/OctoPrint-GcodeEditor";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  marlingcodedocumentation = buildPlugin rec {
    pname = "MarlinGcodeDocumentation";
    version = "0.11.0";

    src = fetchFromGitHub {
      owner = "costas-basdekis";
      repo = pname;
      rev = "v${version}";
      sha256 = "0vx06w9hqwy0k4r8g67y8gdckfdx7wl8ghfx6hmxc1s8fgkghfkc";
    };

    meta = with lib; {
      description = "Displays GCode documentation for Marlin in the Octoprint terminal command line";
      homepage = "https://github.com/costas-basdekis/MarlinGcodeDocumentation";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  mqtt = buildPlugin rec {
    pname = "MQTT";
    version = "0.8.7";

    src = fetchFromGitHub {
      owner = "OctoPrint";
      repo = "OctoPrint-MQTT";
      rev = version;
      sha256 = "0k82h7wafbcqdvk5wjw4dp9lydwszfj1lf8vvymwbqdn7pf5h0dy";
    };

    propagatedBuildInputs = with super; [ paho-mqtt ];

    meta = with lib; {
      description = "Publish printer status MQTT";
      homepage = "https://github.com/OctoPrint/OctoPrint-MQTT";
      license = licenses.agpl3;
      maintainers = with maintainers; [ peterhoeg ];
    };
  };

  printtimegenius = buildPlugin rec {
    pname = "PrintTimeGenius";
    version = "2.2.6";

    src = fetchFromGitHub {
      owner = "eyal0";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "04zfgd3x3lbriyzwhpqnwdcfdm19fsqgsb7l2ix5d0ssmqxwg2r6";
    };

    preConfigure = ''
      # PrintTimeGenius ships with marlin-calc binaries for multiple architectures
      rm */analyzers/marlin-calc*
      sed 's@"{}.{}".format(binary_base_name, machine)@"${pkgs.marlin-calc}/bin/marlin-calc"@' -i */analyzers/analyze_progress.py
    '';

    patches = [
      ./printtimegenius-logging.patch
    ];

    meta = with lib; {
      description = "Better print time estimation for OctoPrint";
      homepage = "https://github.com/eyal0/OctoPrint-PrintTimeGenius";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  psucontrol = buildPlugin rec {
    pname = "PSUControl";
    version = "0.1.9";

    src = fetchFromGitHub {
      owner = "kantlivelong";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1cn009bdgn6c9ba9an5wfj8z02wi0xcsmbhkqggiqlnqy1fq45ca";
    };

    preConfigure = ''
      # optional; RPi.GPIO is broken on vanilla kernels
      sed /RPi.GPIO/d -i requirements.txt
    '';

    meta = with lib; {
      description = "OctoPrint plugin to control ATX/AUX power supply";
      homepage = "https://github.com/kantlivelong/OctoPrint-PSUControl";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  simpleemergencystop = buildPlugin rec {
    pname = "SimpleEmergencyStop";
    version = "1.0.3";

    src = fetchFromGitHub {
      owner = "Sebclem";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "0hhh5grmn32abkix1b9fr1d0pcpdi2r066iypcxdxcza9qzwjiyi";
    };

    meta = with lib; {
      description = "A simple plugin that add an emergency stop buton on NavBar of OctoPrint";
      homepage = "https://github.com/Sebclem/OctoPrint-SimpleEmergencyStop";
      license = licenses.agpl3;
      maintainers = with maintainers; [ WhittlesJr ];
    };
  };

  stlviewer = buildPlugin rec {
    pname = "STLViewer";
    version = "0.4.2";

    src = fetchFromGitHub {
      owner = "jneilliii";
      repo = "OctoPrint-STLViewer";
      rev = version;
      sha256 = "0mkvh44fn2ch4z2avsdjwi1rp353ylmk9j5fln4x7rx8ph8y7g2b";
    };

    meta = with lib; {
      description = "A simple stl viewer tab for OctoPrint";
      homepage = "https://github.com/jneilliii/Octoprint-STLViewer";
      license = licenses.agpl3;
      maintainers = with maintainers; [ abbradar ];
    };
  };

  telegram = buildPlugin rec {
    pname = "Telegram";
    version = "1.6.4";

    src = fetchFromGitHub {
      owner = "fabianonline";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "14d9f9a5m1prcikd7y26qks6c2ls6qq4b97amn24q5a8k5hbgl94";
    };

    propagatedBuildInputs = with super; [ pillow ];

    meta = with lib; {
      description = "Plugin to send status messages and receive commands via Telegram messenger.";
      homepage = "https://github.com/fabianonline/OctoPrint-Telegram";
      license = licenses.agpl3Only;
      maintainers = with maintainers; [ stunkymonkey ];
    };
  };

  themeify = buildPlugin rec {
    pname = "Themeify";
    version = "1.2.2";

    src = fetchFromGitHub {
      owner = "Birkbjo";
      repo = "Octoprint-${pname}";
      rev = "v${version}";
      sha256 = "0j1qs6kyh947npdy7pqda25fjkqinpas3sy0qyscqlxi558lhvx2";
    };

    meta = with lib; {
      description = "Beautiful themes for OctoPrint";
      homepage = "https://github.com/birkbjo/OctoPrint-Themeify";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  titlestatus = buildPlugin rec {
    pname = "TitleStatus";
    version = "0.0.5";

    src = fetchFromGitHub {
      owner = "MoonshineSG";
      repo = "OctoPrint-TitleStatus";
      rev = version;
      sha256 = "10nxjrixg0i6n6x8ghc1ndshm25c97bvkcis5j9kmlkkzs36i2c6";
    };

    meta = with lib; {
      description = "Show printers status in window title";
      homepage = "https://github.com/MoonshineSG/OctoPrint-TitleStatus";
      license = licenses.agpl3;
      maintainers = with maintainers; [ abbradar ];
    };
  };

  touchui = buildPlugin rec {
    pname = "TouchUI";
    version = "0.3.16";

    src = fetchFromGitHub {
      owner = "BillyBlaze";
      repo = "OctoPrint-${pname}";
      rev = version;
      sha256 = "1jlqjirc4ygl4k7jp93l2h6b18jap3mzz8sf2g61j9w0kgv9l365";
    };

    meta = with lib; {
      description = "Touch friendly interface for a small TFT module or phone for OctoPrint";
      homepage = "https://github.com/BillyBlaze/OctoPrint-TouchUI";
      license = licenses.agpl3;
      maintainers = with maintainers; [ gebner ];
    };
  };

  octoklipper = buildPlugin rec {
    pname = "OctoKlipper";
    version = "0.3.2";

    src = fetchFromGitHub {
      owner = "AliceGrey";
      repo = "OctoprintKlipperPlugin";
      rev = version;
      sha256 = "15yg2blbgqp2gdpsqqm8qiiznq5qaq8wss07jimkl0865vrvlz7l";
    };

    meta = with lib; {
      description = "A plugin for a better integration of Klipper into OctoPrint";
      homepage = "https://github.com/AliceGrey/OctoprintKlipperPlugin";
      license = licenses.agpl3;
      maintainers = with maintainers; [ lovesegfault ];
    };
  };

  octoprint-dashboard = buildPlugin rec {
    pname = "OctoPrint-Dashboard";
    version = "1.15.2";

    src = fetchFromGitHub {
      owner = "StefanCohen";
      repo = pname;
      rev = version;
      sha256 = "0p94jwd7kagh3sixhcrqmsgbay4aaf9l1pgyi2b45jym8pvld5n4";
    };

    meta = with lib; {
      description = "A dashboard for Octoprint";
      homepage = "https://github.com/StefanCohen/OctoPrint-Dashboard";
      license = licenses.agpl3;
      maintainers = with maintainers; [ j0hax ];
    };
  };
}
