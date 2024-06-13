lib: rec {
  devices = {
    boxie = {
      id = "WZXJ4VW-ZH4GALN-VSMZY2I-MPPRRRI-HFPCREJ-4RDXZ5D-PFOQ7XH-GHKNGQT";
      name = "boxie";
    };
    cardamom = {
      id = "HA36EVF-2NHSFE5-HZNHEU3-K3AZ6XH-UGPZUK7-GJ6UWK2-ZF7OTGH-KKMD4AK";
      name = "cardamom";
    };
    fennel = {
      id = "PX2DM2G-KYOTRQN-ZAWVAEY-CM2C44K-YKMZZQL-CKAUNNH-4EEJFTJ-7SCNPAR";
      name = "fennel";
    };
    mizuna = {
      id = "IAEFJXY-QJSHL2U-LTSVJLT-X5IDPD7-DCCQ6AA-YVIVVAC-DYUAAUE-ZUKN5AI";
      name = "mizuna";
    };
    xiaomi13 = {
      id = "JLBMBR2-ZHOK3V6-P4SQAF7-M2ROPIT-WVXQMHM-L6IIHYP-AR2XXZH-RTBT7AZ";
      name = "xiaomi13";
    };
  };

  foldersFor = paths@{ config, data }: {
    documents-art = {
      id = "jvz4q-nhazm";
      label = "Documents/Art";
      path = "${paths.data}/Documents/Art";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    documents-finances = {
      id = "y3fcz-dyihh";
      label = "Documents/Finances";
      path = "${paths.data}/Documents/Finances";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    documents-logseq = {
      id = "sx9vy-avxhx";
      label = "Documents/Logseq";
      path = "${paths.data}/Documents/Logseq";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    documents-obsidian = {
      id = "alfya-r6e0v";
      label = "Documents/Obsidian";
      path = "${paths.data}/Documents/Obsidian";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
        devices.xiaomi13.name
      ];
    };

    documents-recipes = {
      id = "r3xfj-4hgsz";
      label = "Documents/Recipes";
      path = "${paths.data}/Documents/Recipes";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    documents-sync = {
      id = "uhzz7-8ci9n";
      label = "Documents/Sync";
      path = "${paths.data}/Documents/Sync";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
        devices.xiaomi13.name
      ];
    };

    games-emu = {
      id = "voxqa-n92qm";
      label = "Games/Emu";
      path = "${paths.data}/Games/Emu";
      devices = [
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    games-outfox = {
      id = "cvzv5-zwlr7";
      label = "Games/OutFox";
      path = "${paths.data}/Games/OutFox";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    menagerie-archive = {
      id = "63suq-kvmj4";
      label = "Menagerie/Archive";
      path = "${paths.data}/Menagerie/Archive";
      devices = [
        devices.boxie.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };

    menagerie-phone = {
      id = "payvw-mhmxl";
      label = "Menagerie/Phone";
      path = "${paths.data}/Menagerie/Phone";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.fennel.name
        devices.mizuna.name
        devices.xiaomi13.name
      ];
    };

    menagerie-saved = {
      id = "nrwmm-jsnrz";
      label = "Menagerie/Saved";
      path = "${paths.data}/Menagerie/Saved";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };

    music = {
      id = "amkxr-tdqkv";
      label = "Music";
      path = "${paths.data}/Music";
      devices = [
        devices.boxie.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };

    pictures-backgrounds = {
      id = "diz2l-1sn3a";
      label = "Pictures/Backgrounds";
      path = "${paths.data}/Pictures/Backgrounds";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
      ];
    };

    pictures-saved = {
      id = "4ym4z-n2uwg";
      label = "Pictures/Saved";
      path = "${paths.data}/Pictures/Saved";
      devices = [
        devices.boxie.name
        devices.cardamom.name
        devices.mizuna.name
        devices.xiaomi13.name
      ];
    };

    videos-movies = {
      id = "fagam-a5fda";
      label = "Videos/Movies";
      path = "${paths.data}/Videos/Movies";
      devices = [
        devices.boxie.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };

    videos-shows = {
      id = "7nwsg-xcbkm";
      label = "Videos/Shows";
      path = "${paths.data}/Videos/Shows";
      devices = [
        devices.boxie.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };

    videos-youtube = {
      id = "f4xdp-gjqsw";
      label = "Videos/YouTube";
      path = "${paths.data}/Videos/YouTube";
      devices = [
        devices.boxie.name
        devices.fennel.name
        devices.mizuna.name
      ];
    };
  };

  foldersForDevice = folders: name: lib.filterAttrs (n: v: builtins.any (d: name == d) v.devices) folders;
}
