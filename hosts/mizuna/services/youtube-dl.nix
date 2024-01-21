{ pkgs, ... }:
let
  data = "/enc/data/Videos/YouTube";
  yt-dlp-conf = pkgs.writeText "yt-dlp.conf" ''
    -i

    -P "${data}"
    -P "temp:${data}/.incomplete"
    -o "%(uploader)s [%(uploader_id)s]/%(upload_date)s - %(title)s - %(resolution)s [%(id)s].%(ext)s"
    -o "infojson:.meta/%(uploader)s [%(uploader_id)s]/%(upload_date)s - %(title)s - %(resolution)s [%(id)s].%(ext)s"
    -o "description:.meta/%(uploader)s [%(uploader_id)s]/%(upload_date)s - %(title)s - %(resolution)s [%(id)s].%(ext)s"

    # Archive Settings
    --download-archive ${data}/.script/yt-dlp-archive.txt
    -a ${data}/.script/yt-dlp-channels.txt

    # Uniform Format
    --prefer-ffmpeg
    --merge-output-format mkv

    # Get All Subs to SRT
    --write-sub
    --all-subs
    --convert-subs srt

    # Get metadata
    --add-metadata
    --write-description
    --write-thumbnail
    --write-info-json
    --embed-metadata
    --embed-thumbnail

    # Debug
    -v

    # Rate Limit
    --limit-rate 5M
    #--max-downloads 10
  '';
  script = pkgs.writeTextFile
    {
      name = "yt-archive";
      executable = true;
      destination = "/bin/yt-archive";
      text = ''
        #!/usr/bin/env bash
        pushd ${data}

        echo 'Downloading new files for an hour...'
        STOP=`date -d 'next hour' +%s`
        while [[ $(date +%s) -lt $STOP ]]; do
            fc1=$(find ${data} -name \*.* -print | wc -l)
            yt-dlp --config-location ${yt-dlp-conf} -a ${data}/.script/yt-dlp-channels.txt --max-downloads 10
            fc2=$(find ${data} -name \*.* -print | wc -l)

            for d in ${data}/*/; do
                mogrify -format jpg "$d/*.webp"
                bn=$(basename "$d")
                mv "${data}/$bn/"*.webp "${data}/.meta/$bn/"
            done

            if [[ $fc1 -eq $fc2 ]]; then
                break
            fi
        done

        echo 'Downloading completed'

        popd
      '';
    };
in
{
  environment.systemPackages = [
    pkgs.unstable.yt-dlp
    pkgs.imagemagick
    script
  ];
}
