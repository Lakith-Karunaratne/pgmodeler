# [Mac OS](https://www.pgmodeler.io/support/installation)

Qt framework: since macOS doesn't come with this toolkit installed by default, download and install it from the official project's web site.

Xcode: the development toolkit for macOS and the minimum requirement is the version 10.2, SDK 10.14 but it's recommended to use the latest version available because, depending on the Qt version, the compilation will fail mainly due to incomplete framework support on a specic macOS SDK.

XML2 library: if you have installed Xcode correctly the needed headers and libraries are installed as well. You'll just need to change a few lines in the building script (see the next section).

PostgreSQL client library: for practical reasons on macOS, the installers provided by EnterpriseDB are strongly recommended since they bundle all the needed headers and libraries.

## edit the `pgmodeler.pri`

```
macx {
  PGSQL_LIB = /Library/PostgreSQL/15/lib/libpq.dylib
  PGSQL_INC = /Library/PostgreSQL/15/include
  XML_INC = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/libxml2
  XML_LIB = /usr/lib/libxml2.dylib
  ...
}
```

Make sure to edit only the section corresponding to your platform. You need to change the values of the variables PGSQL_LIB, PGSQL_INC, XML_INC and XML_LIB. These variables tell the compiler where to find the headers and libraries for libxml2 as well libpq. Update the values according to the location of the files or folders in your system. Save the file and proceed to the next step.

## Build

In the following procedures, to shorten the commands, we are assuming that $QT_ROOT is the full path to the Qt installation which varies from system to system, so remember to replace the variable with the real path according to your system. The variable $INSTALLATION_ROOT is the path where pgModeler should be installed after the building process is complete. Again, don't forget to replace the variables by the respective full path according to the running operating system.

```
1: $QT_ROOT/bin/qmake -r CONFIG+=release pgmodeler.pro
2: make
3: make install
4: $QT_ROOT/bin/macdeployqt $INSTALLATION_ROOT \
                            $INSTALLATION_ROOT/Contents/MacOS/pgmodeler-ch \
                            $INSTALLATION_ROOT/Contents/MacOS/pgmodeler-cli
```

## Dependencies

After successfully compiling the source code and installing the binaries we need to copy some dependencies into the pgModeler's installation folder and run some commands to make the binaries locate them properly. As the previous section, in the steps below replace the variable $INSTALLATION_ROOT by the path were pgModeler is now installed. The variable $PGSQL_ROOT must be replaced by the full path to PostgreSQL's installation folder. The variable $PGMODELER_SOURCE must be replaced by the full path to pgModeler's source code directory, and $MSYS2_ROOT must be replaced by the full path to MSYS2 installation (only for Windows).

```
1: cp $PGSQL_ROOT/lib/libpq.5.dylib $PGSQL_ROOT/lib/libssl.1.* \
      $PGSQL_ROOT/lib/libcrypto.1.* $INSTALLATION_ROOT/Contents/Frameworks
2: install_name_tool -change "@loader_path/../lib/libcrypto.1.1.dylib" "@loader_path/../Frameworks/libcrypto.1.1.dylib" $INSTALLATION_ROOT/Contents/Frameworks/libssl.1.1.dylib
3: install_name_tool -change "@loader_path/../lib/libcrypto.1.1.dylib" "@loader_path/../Frameworks/libcrypto.1.1.dylib" $INSTALLATION_ROOT/Contents/Frameworks/libpq.5.dylib
4: install_name_tool -change "@loader_path/../lib/libssl.1.1.dylib" "@loader_path/../Frameworks/libssl.1.1.dylib" $INSTALLATION_ROOT/Contents/Frameworks/libpq.5.dylib
5: install_name_tool -change libpq.5.dylib "@loader_path/../Frameworks/libpq.5.dylib" $INSTALLATION_ROOT/Contents/Frameworks/libpgconnector.dylib
6: mkdir $INSTALLATION_ROOT/PlugIns/tls
7: cp -r $QT_ROOT/macos/plugins/platforms/tls/* $INSTALLATION_ROOT/PlugIns/tls
```



