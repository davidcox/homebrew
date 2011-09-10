require 'formula'

class Anttweakbar < Formula
  url 'http://www.antisphere.com/Tools/AntTweakBar/AntTweakBar_114.zip'
  homepage 'http://www.antisphere.com/Wiki/tools:anttweakbar'
  md5 '5aaee2ea2bca03a258f8dad494828d7e'

<<<<<<< HEAD
  depends_on 'cmake'
  depends_on 'dos2unix'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
=======
  depends_on 'dos2unix' => :build
>>>>>>> e2009d01293dfc08f906f93492925a530807af86

  def patches
    # this was developed by a windows guy (apparently); need to run dos2unix
    # in order to apply a patch
<<<<<<< HEAD
    system "dos2unix `find src/ -type f`"

    # add build infrastructure (cmake), and patch a few 10.7 issues
    "https://raw.github.com/gist/1163244/fc972c607502fdc088e765a9b6ecde0122566777/atb_patch.diff"
=======
    system 'dos2unix `find src/ -type f`'

    # patch two small issues -- one related to 10.7 compatibility, one related
    # to missing symbols due to an (apparently) erroneous 'extern "C"' wrapper
    'https://raw.github.com/gist/1182684/8afd29c2bef6c410f1886d297012af752c0d0ac3/atb_10_7_patch_minimal.diff'
  end

  def install
    system 'cd src; make -f Makefile.osx'
    lib.install 'lib/libAntTweakBar.dylib'
    include.install 'include/AntTweakBar.h'
>>>>>>> e2009d01293dfc08f906f93492925a530807af86
  end
end
