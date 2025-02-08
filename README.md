# Talos Context Switcher

Inspired by [blendle/kns], `ttx` allows you to switch between Talos contexts.

Additionally, to display the current talos context in your shell prompt.
A simple bash ps1 prompt script is available inspired by [jonmosco/kube-ps1].

[blendle/kns]: https://github.com/blendle/kns
[jonmosco/kube-ps1]: https://github.com/jonmosco/kube-ps1

## Installation

### ttx

To install **ttx** simply run:

```bash
$ curl https://raw.githubusercontent.com/mikemrm/ttx/refs/heads/main/ttx -o /usr/local/bin/ttx && chmod +x $_
```

> [!TIP]
> Ensure [talosctl], [fzf], and [yq] are installed.

### talos-ps1

To install **talos-ps1** download [talos-ps1.sh] and add the following to your `$HOME/.bashrc`:

```bash
source /path/to/talos-ps1.sh
PS1='[\u@\h \W] $(talos_ps1)\$ '
```

> [!TIP]
> Ensure [yq] is installed.

Enable and disable the prompt with `taloson` and `talosoff`.

```bash
[user@host ~] $ taloson
[user@host ~] (⸩⸨|prod-cluster)$ talosctl get nodename
NODE        NAMESPACE   TYPE       ID         VERSION   NODENAME
10.1.2.10   k8s         Nodename   nodename   1         c0.prod.example.com
10.1.2.12   k8s         Nodename   nodename   1         c1.prod.example.com
10.1.2.14   k8s         Nodename   nodename   1         c2.prod.example.com
[user@host ~] (⸩⸨|prod-cluster)$ ttx dev
[user@host ~] (⸩⸨|dev-cluster)$ talosctl get nodename
NODE        NAMESPACE   TYPE       ID         VERSION   NODENAME
10.2.2.10   k8s         Nodename   nodename   1         c0.dev.example.com
10.2.2.12   k8s         Nodename   nodename   1         c1.dev.example.com
10.2.2.14   k8s         Nodename   nodename   1         c2.dev.example.com
[user@host ~] (⸩⸨|dev-cluster)$ talosoff
[user@host ~] $
```

[talosctl]: https://github.com/siderolabs/talos/releases/latest
[fzf]: https://github.com/junegunn/fzf
[yq]: https://github.com/mikefarah/yq

[talos-ps1.sh]: https://raw.githubusercontent.com/mikemrm/ttx/refs/heads/main/talos-ps1.sh
