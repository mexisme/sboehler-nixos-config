{ pkgs, ... }:
{
  systemd.user = {
    services.mbsyncd = {
      description = "mbsync daemon";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.isync}/bin/mbsync -a";
        ExecStartPost= "${pkgs.mu}/bin/mu index";
      };
    };
    timers = {
      mbsyncd = {
        description = "mbsyncd timer";
        timerConfig = {
          OnBootSec = "2m";
          OnUnitActiveSec = "5m";
          Unit="mbsyncd.service";
        };
        wantedBy = ["timers.target"];
      };
    };
  };
}