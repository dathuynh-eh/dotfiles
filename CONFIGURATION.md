# Configuration

## How to enable undercurl for neovim and tmux

<details>
<summary>Click to expand</summary>

### NeoVim

#### Step 1: To check if your terminal supports undercurl, run the following command:

```bash
echo -e "\e[4:3mThis text has an undercurl\e[0m"
```

If the text is displayed with a different color, your terminal does not support undercurl.

#### Step 2: Enable in neovim

```bash
vim.cmd([[ let &t_Cs = "\e[4:3m" ]])
vim.cmd([[ let &t_Ce = "\e[4:0m" ]])
```

#### Step 3: Configure terminal for undercurl in tmux

```bash
echo $TERM
```

- Check for Smulx support

```bash
info -l -x  | grep smulx
```

If it produces no output, proceed.

- Generate a Terminfo File

```bash
infocmp > /tmp/${TERM}.ti
```

- Replace ${TERM} with your terminal type (e.g., xterm-256color).
  Here in this case

```bash
infocmp > /tmp/xterm-256color.ti
```

- Edit the Terminfo File

```bash
nvim /tmp/xterm-256color.ti
```

Add the following line after smul=\E[4m,:

```bash
Smulx=\E[4:%p1%dm,
```

- Restart your terminal

```bash
tic -o ~/.terminfo /tmp/xterm-256color.ti
```

### Tmux

#### Step 1: Add the following lines to your `.tmux.conf`

```bash
set -g default-terminal "xterm-256color"
set -g terminal-overrides ",xterm-256color:Tc"
set -as terminal-overrides ",*:Smulx=\E[4:%p1%dm"
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
```

#### Step 2: Verify Smulx in Tmux

```bash
infocmp -l -x | grep Smulx
```

</details>

## References:

- [How to enable undercurl in neovim terminal and tmux setup guide](https://dev.to/anurag_pramanik/how-to-enable-undercurl-in-neovim-terminal-and-tmux-setup-guide-2ld7)
