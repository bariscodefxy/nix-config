{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  dedicated ? false, # dedicated server
  gamedir ? "valve",
  enableBsp2 ? false, # bsp2 support (for quake)
  enableGles1 ? false, # gles1 renderer (nanogl)
  enableGles2 ? false, # gles2 renderer (glwes)
  enableGl4es ? false, # gles2 renderer (gl4es)
  enableGl ? true, # opengl renderer
  enableSoft ? true, # soft renderer
  enableUtils ? false, # mdldec
}:

stdenv.mkDerivation {
  pname = "xash3d-fwgs";
  version = "2025-02-01";

  nativeBuildInputs = with pkgs; [
    python3
    pkg-config
    makeWrapper
  ];
  buildInputs = with pkgs; [
    SDL2
    libopus
    freetype
    fontconfig
    xorg.libX11
    xorg.xorgproto
  ];

  src = fetchFromGitHub {
    owner = "FWGS";
    repo = "xash3d-fwgs";
    rev = "e9ffe124817e2ad251e3577665bc24f1d2e3dc5b";
    sha256 = "sha256-GzEj+4DWZRt0eChB6Fk5/DVh08wOzBC+/kL/zSBcOEM=";
    fetchSubmodules = true;
  };
  postPatch = ''
      cat <<EOF > scripts/waifulib/zip.py
    #! /usr/bin/env python
    # encoding: utf-8

    from waflib import TaskGen, Task, Logs, Utils
    import zipfile, sys, os

    class ziparchive(Task.Task):
    	color = 'YELLOW'

    	def __str__(self):
    		tgt_str = ' '.join([a.path_from(a.ctx.launch_node()) for a in self.outputs])
    		count = len(self.inputs)
    		return '%s: %d files -> %s' % (self.__class__.__name__, count, tgt_str)

    	def keyword(self):
    		return 'Creating'

    	def run(self):
    		outfile = self.outputs[0].abspath()
    		kwargs = {}
    		kwargs['mode'] = 'w'
    		kwargs['compression'] = zipfile.ZIP_STORED if self.compresslevel == 0 else zipfile.ZIP_DEFLATED

    		if sys.hexversion >= 0x3070000:
    			kwargs['compresslevel'] = self.compresslevel

    		with zipfile.ZipFile(outfile, **kwargs) as zf:
    			for src in self.inputs:
    				infile  = src.abspath()
    				arcfile = src.path_from(self.relative_to)

    				Logs.debug('%s: %s <- %s as %s', self.__class__.__name__, outfile, infile, arcfile)

    				# Create ZipInfo manually to avoid the 1980 timestamp ValueError
    				zinfo = zipfile.ZipInfo(arcfile)
    				zinfo.date_time = (1980, 1, 1, 0, 0, 0)
    				
    				# Preserve permissions
    				st = os.stat(infile)
    				zinfo.external_attr = (st.st_mode & 0xFFFF) << 16
    				
    				zinfo.compress_type = zipfile.ZIP_STORED if (infile.endswith('.png') or self.compresslevel == 0) else zipfile.ZIP_DEFLATED

    				with open(infile, 'rb') as f:
    					zf.writestr(zinfo, f.read())

    @TaskGen.feature('zip')
    def create_zip_archive(self):
    	compresslevel = getattr(self, 'compresslevel', 6)
    	if compresslevel < 0 or compresslevel > 9:
    		self.bld.fatal('Invalid compress level')

    	files = getattr(self, 'files', None)
    	if not files:
    		self.bld.fatal('No files to archive')

    	relative_to = getattr(self, 'relative_to', None)
    	if not relative_to:
    		self.bld.fatal('No relative directory supplied')

    	self.path.get_bld().mkdir()
    	target = self.path.get_bld().make_node(self.name)

    	tsk = self.create_task('ziparchive', files, target)
    	setattr(tsk, 'compresslevel', compresslevel)
    	setattr(tsk, 'relative_to', relative_to)

    	try:
    		inst_to = self.install_path
    		self.install_task = self.add_install_files(
    			install_to=inst_to, install_from=target,
    			chmod=Utils.O644, task=tsk)
    	except AttributeError:
    		pass
    EOF
  '';

  configurePhase =
    let
      optionals = lib.optionals;
      optional = (cond: val: optionals cond [ val ]);
      flags = [
        "-8"
        "-P"
        "--prefix=/"
      ]
      ++ (optional dedicated "-d")
      ++ (optionals (gamedir != "valve") [
        "--gamedir"
        gamedir
      ])
      ++ (optional enableBsp2 "--enable-bsp2")
      ++ (optional enableGles1 "--enable-gles1")
      ++ (optional enableGles2 "--enable-gles2")
      ++ (optional enableGl4es "--enable-gl4es")
      ++ (optional (!enableGl) "--disable-gl")
      ++ (optional (!enableSoft) "--disable-soft")
      ++ (optional enableUtils "--enable-utils");
    in
    ''
      python3 ./waf configure -T release ${lib.strings.escapeShellArgs flags}
    '';

  buildPhase = ''
    python3 ./waf build
  '';

  installPhase = ''
    python3 ./waf install "--destdir=$out"

    # Wrap the existing binary created by waf
    wrapProgram $out/bin/xash3d \
      --prefix LD_LIBRARY_PATH : "$out/lib/xash3d" \
      --set XASH3D_EXTRAS_PAK1 "$out/share/xash3d/valve/extras.pk3"
  '';

  meta = with lib; {
    description = "Xash3D FWGS engine";
    homepage = "https://github.com/FWGS/xash3d-fwgs";
    # this is a mess because of vendoring...
    # maybe the correct thing to do use to simply use `[ unfree gpl3Plus ]` instead
    license = with licenses; [
      unfree
      gpl2Plus
      gpl3Plus
      lgpl3Plus
      mit
      bsd3
    ];
    # maintainers = with maintainers; [ chayleaf ];
  };
}
