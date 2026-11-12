# Atari Breakout — 8086 Assembly

A small **Breakout-style arcade game** written in 16-bit x86 assembly. It is built as a DOS `.COM` program and can be played in **DOSBox**.

The game uses the 80×25 VGA text screen for its graphics, BIOS keyboard services for input, and PC-speaker I/O for sound effects. There are no external game libraries or assets: the title and end screens are drawn from bitmap data stored in the assembly source.

## Features

- Title screen, rules screen, and difficulty selection
- 52 bricks arranged in four coloured rows
- Paddle and ball movement with wall, brick, and paddle collision handling
- Three lives and a score counter
- Easy, Medium, and Hard speed settings
- Pause/resume, restart, and exit controls
- PC-speaker sound effects and a screen-flash effect when a life is lost
- Custom bitmap-style title, win, and game-over screens

## Controls

| Key | Action |
|---|---|
| Left Arrow | Move the paddle left |
| Right Arrow | Move the paddle right |
| `P` | Pause; press another key to resume |
| `Esc` | Exit the game |
| `Enter` | Continue from the rules screen |
| `1` / `2` / `3` | Select Easy / Medium / Hard |
| `R` | Restart after winning or losing |

At launch, press any key on the title screen, press `Enter` on the rules screen, and then choose a difficulty.

## Requirements

- [NASM](https://www.nasm.us/) — to assemble `blocks.asm`
- [DOSBox](https://www.dosbox.com/) — to run the resulting DOS executable

The game is designed for a DOS-compatible 16-bit environment. It is not a native Windows application and should be run inside DOSBox (or a compatible DOS emulator).

## Build

Run the following command from the repository directory:

```bash
nasm -f bin blocks.asm -o breakout.com
```

This produces `breakout.com` in the current directory.

## Run in DOSBox

Start DOSBox and mount the repository directory as a DOS drive.

**Windows example** (replace the path with the actual location of your cloned repository):

```dos
mount c C:\Users\YourName\Documents\Atari-Breakout-8086
c:
breakout.com
```

Replace the example path with the folder where you cloned the repository.

**Linux example:**

```dos
mount c /home/yourname/projects/Atari-Breakout-8086
c:
breakout.com
```

You can also build the `.COM` file before opening DOSBox, then mount the folder containing both `blocks.asm` and `breakout.com`.

## Project structure

```text
Atari-Breakout-8086/
├── blocks.asm    # 8086 assembly source code
├── README.md     # Project overview and build/run instructions
└── .gitignore    # Ignore generated binaries and build files
```

## Implementation notes

- **Output:** Direct writes to colour text-mode video memory at `B800h`.
- **Input:** BIOS keyboard interrupts (`INT 16h`).
- **Program exit:** DOS interrupt (`INT 21h`).
- **Sound:** PC-speaker control through I/O ports.
- **Executable format:** Flat binary DOS `.COM`, assembled with NASM's `-f bin` output format and an origin of `0100h`.

The difficulty setting changes the ball's loop-based delay. The resulting game speed can therefore depend on the DOSBox CPU-cycle configuration.

## Notes

The repository contains the assembly source; `breakout.com` is generated locally by the build command and is intentionally excluded from version control.
