{ lib, ... }:
{
  imports =
    lib.filesystem.listFilesRecursive ./stable
    ++ lib.filesystem.listFilesRecursive ./unstable;
}
