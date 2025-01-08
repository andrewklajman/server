let
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdBGjT+ceq/StfVrN3nZ4fRHCWezIOdN0wGCe6yZaaB root@nixos";
in
{
  "tailscale.age".publicKeys = [ system ];
} 
