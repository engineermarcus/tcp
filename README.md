

**On the phone** (if you haven't already authenticated):
```
tailscale-cli up
```
It'll print a login URL — open it anywhere, authorize.

Then get the phone's permanent address:
```
tailscale-cli ip -4
```
That gives you a `100.x.x.x` address — note it down.

**On your computer**, install Tailscale the normal way for your OS:
```
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
(or the equivalent installer if you're not on Linux — tell me your computer's OS if it's not Linux and I'll adjust)

Log in with the **same Tailscale account** you used on the phone — this is the part that actually links them into one private network.

**Then connect:**
```
ssh u0_a164@<phone's-100.x.x.x-address> -p 8022
```

What does the phone show right now — did `tailscale-cli up` already give you a Tailscale IP, or are you starting that step now?
