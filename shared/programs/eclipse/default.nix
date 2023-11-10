{ config, pkgs, ... }:
{

# Different Approach:
# https://github.com/NixOS/nixpkgs/blob/master/doc/builders/packages/eclipse.section.md


# Added functionality
# - Install ADT tooling
# - Other other required plugins
# - Try out oomph for eclipse configuration


programs.eclipse = {
	enable = true;
	# jvmArgs = [ "-javaagent:${pkgs.lombok.out}/share/java/lombok.jar" ];
	# plugins = [ ];
};

}
