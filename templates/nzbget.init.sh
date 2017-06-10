#!/bin/sh
### BEGIN INIT INFO
# Default-Start:     2 3 4 5
# Provides:          nzbget
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: start the nzbget processes
# Description:       starts and stops nzbget
# Author:            Jens / Gunter
# Version:           1.0a
### END INIT INFO

NAME=nzbget
DESC=NZBGet

# User to run the daemon
NZBGET_USER={{ nzbget_user }}
# Path to configfile
NZBGET_CONF=/etc/nzbget.conf
# nzbget executable
NZBGET_BIN=/usr/local/bin/nzbget

# Usually MainDir/nzbget.lock 
# Check LockFile setting in your nzbget.conf
PID_FILE=/run/nzbget/nzbget.pid

#######################################################################
##
### NO MODIFICATIONS PAST THIS LINE
##
#######################################################################

RETVAL=0

set -e

. /lib/lsb/init-functions

PATH=${PATH}:/sbin

if [ -e $PID_FILE ]; then
    PID=`cat $PID_FILE`
    if ! kill -0 $PID > /dev/null 2>&1; then
        echo "Removing stale $PID_FILE"
        rm $PID_FILE
    fi
fi

if [ ! -d "$(dirname "${PID_FILE}")"]; then
    mkdir -p "$(dirname "${PID_FILE}")"
    chown ${NZBGET_USER}:${NZBGET_GROUP} "$(dirname "${PID_FILE}")"
fi

do_start()
{
  start-stop-daemon --start --quiet --chuid ${NZBGET_USER} --exec ${NZBGET_BIN} -- -D -c ${NZBGET_CONF}
  RETVAL="$?"
  return "$RETVAL"
}
do_stop()
{
  start-stop-daemon --stop --pidfile $PID_FILE --retry=TERM/15/KILL/5
  RETVAL="$?"
  return "$RETVAL"
}

case "$1" in
  start)
    log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    case "$?" in
        0|1) log_end_msg 0 ;;
        2) log_end_msg 1 ;;
    esac
    ;;
  stop)
    log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
        0|1) log_end_msg 0 ;;
        2) log_end_msg 1 ;;
    esac
    ;;
  restart)
      log_daemon_msg "Restarting $DESC" "$NAME"
      do_stop
      case "$?" in
        0|1)
          do_start
            case "$?" in
              0) log_end_msg 0 ;;
              1) log_end_msg 1 ;; # Old process is still running
              *) log_end_msg 1 ;; # Failed to start
            esac
            ;;
        *)
          # Failed to stop
          log_end_msg 1
          ;;
      esac
    ;;
  status)
    status_of_proc -p $PID_FILE "$NZBGET_BIN" "$NAME" && exit 0 || exit $?
    ;;
  *)
          echo "Usage: /etc/init.d/$NAME {start|stop|restart|status}" >&2
          exit 3
    ;;
esac
exit $RETVAL
