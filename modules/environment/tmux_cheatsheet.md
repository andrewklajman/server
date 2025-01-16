https://tmuxcheatsheet.com/

# Sessions

    tmux ........................... Create a session
        , new/new-session -s <name>
	, -A/attach-session <name>
	, :new -s <name>

    tmux ........................... Kill a session
        , kill-session -t <name>
	, kill-session -a                * Kill all sessions except for current
        , :kill-session 

    tmux ........................... Manage sessions
        , list-sessions 
        , Ctrl + a $                     * Rename session
        , Ctrl + a d                     * Detatch session
        , Ctrl + a w                     * Session and Window Preview
        , Ctrl + a ( / )                 * Move to previous / next session
       
# Windows

    Shortcut + 
        c ...... Create window
        , ...... Rename window
        & ...... Close window
        w ...... List windows
        p ...... Previous window
        n ...... Next window
        0..9 ... Select window
        l ...... Last active window

# Panes

    Shortcut + 
        ; ........ Toggle last active pane
	% ........ Horizontal split
	" ........ Vertical split
	{ ........ Move pane to left
	} ........ Move pane to right
	hjkl ..... Activate pane 
	HJKL ..... Change pane size
	Space .... Change configuration
	o ........ Switch to next pane
	q ........ Show pane numbers
	q 0..9 ... Switch to pane number
	z ........ Toggle zoom
	! ........ Convert to a window
	x ........ Close pane

	:join-pane -s 2 -t 1 ... Join Window 2 to Window 1
	:join-pane -s 2.1 -t 1.0 ... Join Window 2 Pane 1 to Window 1

# Copy mode

    Shortcut + 
        [ ........ Enter copy mode
	PgUp ..... Scroll up
	q ........ Quit
	Space .... Start selection
	Esc ...... Clear
	Enter .... Copy selection
        ] ........ Paste content to buffer 0
