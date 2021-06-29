# binaryen
xpProOption(binaryen)
set(VER 101)
set(REPO github.com/WebAssembly/binaryen)
set(PRO_BINARYEN
  NAME binaryen
  WEB "Binaryen" https://${REPO} "Binaryen on GitHub"
  LICENSE "open" https://${REPO}/blob/main/LICENSE "Apache 2.0"
  DESC "compiler and toolchain infrastructure library for WebAssembly"
  REPO "repo" https://${REPO} "Binaryen repo on GitHub"
  VER ${VER}
  GIT_ORIGIN git://${REPO}.git
  GIT_TAG version_${VER}
  DLURL https://${REPO}/archive/version_${VER}.tar.gz
  DLMD5 633105328e64cd0fef36f56ee2be7b09
  DLNAME binaryen-${VER}.tar.gz
  )
########################################
function(build_binaryen)
  if(NOT (XP_DEFAULT OR XP_PRO_BINARYEN))
    return()
  endif()
  xpGetArgValue(${PRO_BINARYEN} ARG VER VALUE VER)
  set(verDir /binaryen_${VER})
  configure_file(${PRO_DIR}/use/usexp-binaryen-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  ExternalProject_Get_Property(binaryen SOURCE_DIR)
  set(headers ${SOURCE_DIR}/*.h)
  ExternalProject_Add(binaryen_bld DEPENDS ${depTgts} binaryen
    DOWNLOAD_COMMAND "" DOWNLOAD_DIR ${DWNLD_DIR} CONFIGURE_COMMAND ""
    SOURCE_DIR ${SOURCE_DIR} BINARY_DIR ${NULL_DIR}
    INSTALL_DIR ${STAGE_DIR}/include${verDir}/binaryen
    BUILD_COMMAND ${CMAKE_COMMAND} -Dsrc:STRING=${headers}
      -Ddst:STRING=<INSTALL_DIR> -P ${MODULES_DIR}/cmscopyfiles.cmake
    INSTALL_COMMAND ""
    )
  set_property(TARGET binaryen_bld PROPERTY FOLDER ${bld_folder})
  message(STATUS "target binaryen_bld")
endfunction()
