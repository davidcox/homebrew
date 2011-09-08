require 'formula'

class Anttweakbar < Formula
  url 'http://www.antisphere.com/Tools/AntTweakBar/AntTweakBar_114.zip'
  homepage 'http://www.antisphere.com/Wiki/tools:anttweakbar'
  md5 '5aaee2ea2bca03a258f8dad494828d7e'

  depends_on 'dos2unix' => :build

  def install
    system "cd src; make -f Makefile.osx"
    lib.install('./lib/libAntTweakBar.dylib')
    include.install('./include/AntTweakBar.h')
  end

  def patches
    # this was developed by a windows guy (apparently); need to run dos2unix
    # in order to apply a patch
    system "dos2unix `find src/ -type f`"

    # patch two small issues -- one related to 10.7 compatibility, one related
    # to missing symbols due to an (apparently) erroneous 'extern "C"' wrapper
    DATA

  end
end

__END__
diff --git a/src/LoadOGL.h b/src/LoadOGL.h
index 18dd25d..db05586 100755
--- a/src/LoadOGL.h
+++ b/src/LoadOGL.h
@@ -346,7 +346,7 @@ ANT_GL_DECL(void, glTexGenf, (GLenum coord, GLenum pname, GLfloat param))
 ANT_GL_DECL(void, glTexGenfv, (GLenum coord, GLenum pname, const GLfloat *params))
 ANT_GL_DECL(void, glTexGeni, (GLenum coord, GLenum pname, GLint param))
 ANT_GL_DECL(void, glTexGeniv, (GLenum coord, GLenum pname, const GLint *params))
-#if defined(ANT_OSX)
+#if defined(ANT_OSX) && (MAC_OS_X_VERSION_MAX_ALLOWED < 1070) // Mac OS X 10.7
 // Mac OSX redefined these OpenGL calls: glTexImage1D, glTexImage2D
 ANT_GL_DECL(void, glTexImage1D, (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels))
 ANT_GL_DECL(void, glTexImage2D, (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels))
diff --git a/src/TwEventSDL.c b/src/TwEventSDL.c
index 5371dde..5806f34 100755
--- a/src/TwEventSDL.c
+++ b/src/TwEventSDL.c
@@ -18,7 +18,14 @@
 
 int TW_CALL TwEventSDL12(const void *sdlEvent); // implemented in TwEventSDL12.c
 int TW_CALL TwEventSDL13(const void *sdlEvent); // implmeneted in TwEventSDL13.c
+#ifdef __cplusplus
+extern "C" {
+#endif
 int TW_CALL TwSetLastError(const char *staticErrorMessage);
+#ifdef __cplusplus
+}
+#endif
+
 
 //  TwEventSDL returns zero if msg has not been handled or the SDL version 
 //  is not supported, and a non-zero value if it has been handled by the 



