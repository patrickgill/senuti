/* File : gpod.i.in */

/*
 Copyright (C) 2007 Nick Piper <nick-gtkpod at nickpiper co uk>
 Part of the gtkpod project.
 
 URL: http://www.gtkpod.org/
 URL: http://gtkpod.sourceforge.net/

 The code contained in this file is free software; you can redistribute
 it and/or modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either version
 2.1 of the License, or (at your option) any later version.

 This file is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public
 License along with this code; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 $Id$

Please send any fixes, improvements or suggestions to
<nick-gtkpod at nickpiper co uk>.

*/

%define DOCSTRING
"This module gives access to an iPod's content. It provides an easy to
use API to retrieve the list of files and playlists stored on an iPod,
modify them, and save them back to the iPod.

This module implements the libgpod C API as directly as possible in
Python.  See the main gpod module for a more traditional Python
interface."
%enddef

%pythoncode %{
version = "0.8.3"
version_info = version.split(".")
%}

%module(docstring=DOCSTRING) gpod
%{
#include "../../config.h"
#include "db-artwork-debug.h" 
#include "db-artwork-parser.h" 
#include "db-image-parser.h" 
#include "db-itunes-parser.h" 
#include "db-parse-context.h" 
#include "itdb.h" 
#include "itdb_device.h" 
#include "itdb_private.h"
#include <time.h>
#include <datetime.h>
#ifdef HAVE_GDKPIXBUF
#ifdef HAVE_PYGOBJECT
#include <gdk-pixbuf/gdk-pixbuf.h>
#include <pygobject.h>
#endif
#endif


/* include prototypes for all functions so builds using
 * -Wmissing-prototypes don't fail. */
PyObject* sw_get_tracks(Itdb_iTunesDB *itdb);
PyObject* sw_get_track(GList *list, gint index);
PyObject* sw_get_rule(GList *list, gint index);
PyObject* sw_get_playlist(GList *list, gint index);
PyObject* sw_get_list_len(GList *list);
PyObject* sw_get_playlists(Itdb_iTunesDB *itdb);
PyObject* sw_get_playlist_tracks(Itdb_Playlist *pl);
PyObject* sw_set_track_userdata(Itdb_Track *track, PyObject *data);
PyObject* sw_get_track_userdata(Itdb_Track *track);
PyObject* sw__track_extra_duplicate (PyObject *data);
PyObject* sw_get_photoalbums(Itdb_PhotoDB *db);
PyObject* sw_get_photoalbum(GList *list, gint index);
PyObject* sw_get_photos(Itdb_PhotoDB *db);
PyObject* sw_get_photo(GList *list, gint index);
PyObject* sw_get_photoalbum_members(Itdb_PhotoAlbum *album);
PyObject* sw_ipod_device_to_dict(Itdb_Device *device);
void sw__track_extra_destroy (PyObject *data);
void hash_table_to_pydict(gpointer key, gpointer value, gpointer user_data);
void SWIG_init(void);

PyObject* sw_get_tracks(Itdb_iTunesDB *itdb) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(itdb->tracks));
  for (l = itdb->tracks, i = 0; l; l = l->next, ++i) {
    PyList_SET_ITEM(list, i, SWIG_NewPointerObj((void*)(l->data), SWIGTYPE_p__Itdb_Track, 0));
  }
  return list;
 }

PyObject* sw_get_track(GList *list, gint index) {
  GList *position;
  if ( (index >= g_list_length(list)) || index < 0 ) {
   PyErr_SetString(PyExc_IndexError, "Value out of range");
   return NULL;
  }
  position = g_list_nth(list, index);
  return SWIG_NewPointerObj((void*)(position->data), SWIGTYPE_p__Itdb_Track, 0);
 }

PyObject* sw_get_rule(GList *list, gint index) {
  GList *position;
  if ( (index >= g_list_length(list)) || index < 0 ) {
   PyErr_SetString(PyExc_IndexError, "Value out of range");
   return NULL;
  }
  position = g_list_nth(list, index);
  return SWIG_NewPointerObj((void*)(position->data), SWIGTYPE_p__Itdb_SPLRule, 0);
 }

PyObject* sw_get_playlist(GList *list, gint index) {
  GList *position;
  if ( (index >= g_list_length(list)) || index < 0 ) {
   PyErr_SetString(PyExc_IndexError, "Value out of range");
   return NULL;
  }
  position = g_list_nth(list, index);
  return SWIG_NewPointerObj((void*)(position->data), SWIGTYPE_p__Itdb_Playlist, 0);
 }

PyObject* sw_get_list_len(GList *list) {
   return PyInt_FromLong(g_list_length(list));
 }

PyObject* sw_get_playlist_tracks(Itdb_Playlist *pl) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(pl->members));
  for (l = pl->members, i = 0; l; l = l->next, ++i) {
    PyList_SET_ITEM(list, i, SWIG_NewPointerObj((void*)(l->data), SWIGTYPE_p__Itdb_Track, 0));
  }
  return list;
 }

PyObject* sw_get_playlists(Itdb_iTunesDB *itdb) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(itdb->playlists));
  for (l = itdb->playlists, i = 0; l; l = l->next, ++i) {
    PyList_SET_ITEM(list, i, SWIG_NewPointerObj((void*)(l->data), SWIGTYPE_p__Itdb_Playlist, 0));
  }
  return list;
 }
 
 void sw__track_extra_destroy (PyObject *data) {
   Py_XDECREF(data);   
 }

 PyObject *sw__track_extra_duplicate (PyObject *data) {
   if (data == Py_None) {
     Py_INCREF(Py_None);
     return Py_None;
   } else {
     return PyDict_Copy(data);
   }
 }

 PyObject *sw_set_track_userdata(Itdb_Track *track, PyObject *data) {
   Py_INCREF(data);
   if ((PyDict_Check(data)) || (data == Py_None)) {
     if (track->userdata) {
       Py_DECREF((PyObject *)track->userdata);
     }
     track->userdata = (gpointer) data;
     track->userdata_duplicate = (ItdbUserDataDuplicateFunc)sw__track_extra_duplicate;
     track->userdata_destroy   = (ItdbUserDataDestroyFunc)sw__track_extra_destroy;
     Py_INCREF(Py_None);
     return Py_None;
   } else {
     PyErr_SetString(PyExc_TypeError, "userdata must be a Dictionary");
     return NULL;
   }
 }
 
 PyObject* sw_get_track_userdata(Itdb_Track *track) {
   if (track->userdata) {
     Py_INCREF((PyObject *)track->userdata);
     return (PyObject *)track->userdata;
   } else {
     Py_INCREF(Py_None);
     return Py_None;
   }
 }

 PyObject* sw_get_photoalbums(Itdb_PhotoDB *db) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(db->photoalbums));
  for (l = db->photoalbums, i = 0; l; l = l->next, ++i) {
    PyList_SET_ITEM(list, i, SWIG_NewPointerObj((void*)(l->data),
SWIGTYPE_p__Itdb_PhotoAlbum, 0));
  }
  return list;
 }

PyObject* sw_get_photoalbum(GList *list, gint index) {
  GList *position;
  if ( (index >= g_list_length(list)) || index < 0 ) {
   PyErr_SetString(PyExc_IndexError, "Value out of range");
   return NULL;
  }
  position = g_list_nth(list, index);
  return SWIG_NewPointerObj((void*)(position->data), SWIGTYPE_p__Itdb_PhotoAlbum, 0);
 }

 PyObject* sw_get_photoalbum_members(Itdb_PhotoAlbum *album) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(album->members));
  for (l = album->members, i = 0; l; l = l->next, ++i) {
    gint photo_id = GPOINTER_TO_INT(l->data);
    PyList_SET_ITEM(list, i, PyInt_FromLong((long)photo_id));
  }
  return list;
 }

 PyObject* sw_get_photos(Itdb_PhotoDB *db) {
  PyObject    *list;
  gint        i;
  GList       *l;
  list = PyList_New(g_list_length(db->photos));
  for (l = db->photos, i = 0; l; l = l->next, ++i) {
    PyList_SET_ITEM(list, i, SWIG_NewPointerObj((void*)(l->data),
SWIGTYPE_p__Itdb_Artwork, 0));
  }
  return list;
 }

PyObject* sw_get_photo(GList *list, gint index) {
  GList *position;
  if ( (index >= g_list_length(list)) || index < 0 ) {
   PyErr_SetString(PyExc_IndexError, "Value out of range");
   return NULL;
  }
  position = g_list_nth(list, index);
  return SWIG_NewPointerObj((void*)(position->data), SWIGTYPE_p__Itdb_Artwork, 0);
 }

 void hash_table_to_pydict(gpointer key,
			   gpointer value,
			   gpointer user_data) {
   PyDict_SetItemString((PyObject *)user_data, 
			(char *)key,
			PyString_FromString(value));
 }

 PyObject* sw_ipod_device_to_dict(Itdb_Device *device) {
   PyObject* sysinfo;
   if (device == NULL) {
     Py_INCREF(Py_None);
     return Py_None;
   } else {
     sysinfo = PyDict_New();
     g_hash_table_foreach(device->sysinfo, 
			  hash_table_to_pydict, 
			  (gpointer) sysinfo);
     return Py_BuildValue("{s:s,s:i,s:i,s:O,s:i}",
			  "mountpoint",
			  device->mountpoint,
			  "musicdirs",
			  device->musicdirs,
			  "byte_order",
			  device->byte_order,
			  "sysinfo",
			  sysinfo,
                          "timezone_shift",
                          device->timezone_shift);
   }
 }

%}

%init %{
#ifdef HAVE_GDKPIXBUF
#ifdef HAVE_PYGOBJECT
#if !GLIB_CHECK_VERSION(2, 36, 0)
   g_type_init ();
#endif
   init_pygobject ();
#endif
#endif
   PyDateTime_IMPORT;
%}

%include "gpod_doc.i"
%include "../../config.h"

# be nicer to decode these utf8 strings into Unicode objects in the C
# layer. Here we are leaving it to the Python side, and just giving
# them utf8 encoded Strings.
typedef char gchar;

%typemap(in) time_t {
  struct tm tmvalue;
  PyObject* pydatetime = NULL;
  if (PyDateTime_Check($input)) {
    pydatetime = $input;
    Py_INCREF(pydatetime);
  } else if  ((PyInt_Check($input)) || (PyLong_Check($input)) || (PyFloat_Check($input))) {
    PyObject* pyargs;
    Py_INCREF($input);
    pyargs = PyTuple_Pack(1, $input);
    if ((pydatetime = PyDateTime_FromTimestamp(pyargs)) == NULL) {
      Py_DECREF(pyargs);
      Py_DECREF($input);
      SWIG_fail;
    }
    Py_DECREF(pyargs);
    Py_DECREF($input);
  } else {
    PyErr_SetString(PyExc_ValueError, "$symname: Value must be a datetime.datetime, int or float");
    SWIG_fail;
  }
  tmvalue.tm_year = PyDateTime_GET_YEAR(pydatetime)  - 1900;
  tmvalue.tm_mon  = PyDateTime_GET_MONTH(pydatetime) - 1;
  tmvalue.tm_mday = PyDateTime_GET_DAY(pydatetime);
  tmvalue.tm_hour = PyDateTime_DATE_GET_HOUR(pydatetime);
  tmvalue.tm_min  = PyDateTime_DATE_GET_MINUTE(pydatetime);
  tmvalue.tm_sec  = PyDateTime_DATE_GET_SECOND(pydatetime);

  Py_DECREF(pydatetime);
  
  $1 = mktime(&tmvalue);
  if ($1 == -1) {
    PyErr_SetString(PyExc_ValueError, "$symname: Failed to parse provided time");	
    SWIG_fail;    
  }
}

%typemap(out) time_t {
#ifdef 0
  /* for libgpod 0.6.x.. maybe ? */
  struct tm *tmvalue;
  tmvalue = localtime(&$1);
  $result = PyDateTime_FromDateAndTime(tmvalue->tm_year + 1900,
				       tmvalue->tm_mon  + 1,
				       tmvalue->tm_mday,
				       tmvalue->tm_hour,
				       tmvalue->tm_min,
				       tmvalue->tm_sec,
				       0);
#else
  $result = PyLong_FromUnsignedLong((unsigned long) $1);
#endif
}

%typemap(in) guint8 {
   unsigned long ival;
   ival = PyInt_AsUnsignedLongMask($input);
   if (PyErr_Occurred())
        SWIG_fail;
   if (ival > 255) {
      PyErr_SetString(PyExc_ValueError, "$symname: Value must be between 0 and 255");
      SWIG_fail;
   } else {
      $1 = (guint8) ival;
   }
}

%typemap(in) gint8 {
   long ival;
   ival = PyInt_AsInt($input);
   if (PyErr_Occurred())
        SWIG_fail;
   if ((ival < -128) || (ival > 127)) {
      PyErr_SetString(PyExc_ValueError, "$symname: Value must be between -128 and 127");
      SWIG_fail;
   } else {
      $1 = (gint8) ival;
   }
}

%typemap(in) guint16 {
   unsigned long ival;
   ival = PyInt_AsUnsignedLongMask($input);
   if (PyErr_Occurred())
        SWIG_fail;
   if (ival > 65535) {
      PyErr_SetString(PyExc_ValueError, "$symname: Value must be between 0 and 65535");
      SWIG_fail;
   } else {
      $1 = (guint16) ival;
   }
}

%typemap(in) gint16 {
   long ival;
   ival = PyInt_AsLong($input);
   if (PyErr_Occurred())
        SWIG_fail;
   if ((ival < -32768) || (ival > 32767)) {
      PyErr_SetString(PyExc_ValueError, "$symname: Value must be between -32,768 and 32,767");
      SWIG_fail;
   } else {
      $1 = (gint16) ival;
   }
}

%typemap(in) guint32 {
   unsigned long ival;
   ival = PyInt_AsUnsignedLongMask($input);
   if (PyErr_Occurred())
        SWIG_fail;
   $1 = (guint32) ival;
}

%typemap(in) gint32 {
   long ival;
   ival = PyInt_AsLong($input);
   if (PyErr_Occurred())
        SWIG_fail;
   $1 = (gint32) ival;
}

%typemap(in) guint64 {
  if (PyInt_CheckExact($input))
    $1 = PyInt_AsUnsignedLongLongMask($input);
  else
    $1 = PyLong_AsUnsignedLongLong($input);
  if (PyErr_Occurred())
    SWIG_fail;
}

%typemap(in) gint64 {
  if (PyInt_CheckExact($input))
    $1 = PyInt_AsLong($input);
  else
    $1 = PyLong_AsLongLong($input);
  if (PyErr_Occurred())
    SWIG_fail;
}

%typemap(out) guint64 {
   $result = PyLong_FromUnsignedLongLong($1);
}

%typemap(out) gint64 {
   $result = PyLong_FromLongLong($1);
}

%typemap(out) guint32 {
   $result = PyLong_FromUnsignedLong($1);
}

%typemap(out) gint32 {
   $result = PyLong_FromLong($1);
}

%typemap(out) guint16 {
   $result = PyLong_FromUnsignedLong($1);
}

%typemap(out) gint16 {
   $result = PyLong_FromLong($1);
}

%typemap(out) guint8 {
   $result = PyInt_FromLong($1);
}

typedef int gboolean;
typedef int gint;

#ifdef HAVE_GDKPIXBUF
#ifdef HAVE_PYGOBJECT
%typemap(out) gpointer itdb_artwork_get_pixbuf {
  $result = pygobject_new((GObject *)$1);
  if ($1) {
      g_object_unref($1);
  }
}

%typemap(in) gpointer pixbuf {
  $1 = GDK_PIXBUF(pygobject_get($input));
}
#endif
#endif

#define G_BEGIN_DECLS
#define G_END_DECLS

PyObject* sw_get_tracks(Itdb_iTunesDB *itdb);
PyObject* sw_get_track(GList *list, gint index);
PyObject* sw_get_rule(GList *list, gint index);
PyObject* sw_get_playlist(GList *list, gint index);
PyObject* sw_get_list_len(GList *list);
PyObject* sw_get_playlists(Itdb_iTunesDB *itdb);
PyObject* sw_get_playlist_tracks(Itdb_Playlist *pl);
PyObject* sw_set_track_userdata(Itdb_Track *track, PyObject *data);
PyObject* sw_get_track_userdata(Itdb_Track *track);
PyObject* sw_get_photoalbums(Itdb_PhotoDB *db);
PyObject* sw_get_photoalbum(GList *list, gint index);
PyObject* sw_get_photos(Itdb_PhotoDB *db);
PyObject* sw_get_photo(GList *list, gint index);
PyObject* sw_get_photoalbum_members(Itdb_PhotoAlbum *album);
PyObject* sw_ipod_device_to_dict(Itdb_Device *device);

%include "../../src/itdb.h"
