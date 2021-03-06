/* LCM type definition class file
 * This file was automatically generated by lcm-gen
 * DO NOT MODIFY BY HAND!!!!
 */

package exlcm;
 
import java.io.*;
import java.util.*;
import lcm.lcm.*;
 
public final class gpsData implements lcm.lcm.LCMEncodable
{
    public long timestamp;
    public float lat;
    public String latDir;
    public float lon;
    public String lonDir;
    public float alt;
    public float utm_x;
    public float utm_y;
 
    public gpsData()
    {
    }
 
    public static final long LCM_FINGERPRINT;
    public static final long LCM_FINGERPRINT_BASE = 0x68be2ac79e87db4dL;
 
    static {
        LCM_FINGERPRINT = _hashRecursive(new ArrayList<Class<?>>());
    }
 
    public static long _hashRecursive(ArrayList<Class<?>> classes)
    {
        if (classes.contains(exlcm.gpsData.class))
            return 0L;
 
        classes.add(exlcm.gpsData.class);
        long hash = LCM_FINGERPRINT_BASE
            ;
        classes.remove(classes.size() - 1);
        return (hash<<1) + ((hash>>63)&1);
    }
 
    public void encode(DataOutput outs) throws IOException
    {
        outs.writeLong(LCM_FINGERPRINT);
        _encodeRecursive(outs);
    }
 
    public void _encodeRecursive(DataOutput outs) throws IOException
    {
        char[] __strbuf = null;
        outs.writeLong(this.timestamp); 
 
        outs.writeFloat(this.lat); 
 
        __strbuf = new char[this.latDir.length()]; this.latDir.getChars(0, this.latDir.length(), __strbuf, 0); outs.writeInt(__strbuf.length+1); for (int _i = 0; _i < __strbuf.length; _i++) outs.write(__strbuf[_i]); outs.writeByte(0); 
 
        outs.writeFloat(this.lon); 
 
        __strbuf = new char[this.lonDir.length()]; this.lonDir.getChars(0, this.lonDir.length(), __strbuf, 0); outs.writeInt(__strbuf.length+1); for (int _i = 0; _i < __strbuf.length; _i++) outs.write(__strbuf[_i]); outs.writeByte(0); 
 
        outs.writeFloat(this.alt); 
 
        outs.writeFloat(this.utm_x); 
 
        outs.writeFloat(this.utm_y); 
 
    }
 
    public gpsData(byte[] data) throws IOException
    {
        this(new LCMDataInputStream(data));
    }
 
    public gpsData(DataInput ins) throws IOException
    {
        if (ins.readLong() != LCM_FINGERPRINT)
            throw new IOException("LCM Decode error: bad fingerprint");
 
        _decodeRecursive(ins);
    }
 
    public static exlcm.gpsData _decodeRecursiveFactory(DataInput ins) throws IOException
    {
        exlcm.gpsData o = new exlcm.gpsData();
        o._decodeRecursive(ins);
        return o;
    }
 
    public void _decodeRecursive(DataInput ins) throws IOException
    {
        char[] __strbuf = null;
        this.timestamp = ins.readLong();
 
        this.lat = ins.readFloat();
 
        __strbuf = new char[ins.readInt()-1]; for (int _i = 0; _i < __strbuf.length; _i++) __strbuf[_i] = (char) (ins.readByte()&0xff); ins.readByte(); this.latDir = new String(__strbuf);
 
        this.lon = ins.readFloat();
 
        __strbuf = new char[ins.readInt()-1]; for (int _i = 0; _i < __strbuf.length; _i++) __strbuf[_i] = (char) (ins.readByte()&0xff); ins.readByte(); this.lonDir = new String(__strbuf);
 
        this.alt = ins.readFloat();
 
        this.utm_x = ins.readFloat();
 
        this.utm_y = ins.readFloat();
 
    }
 
    public exlcm.gpsData copy()
    {
        exlcm.gpsData outobj = new exlcm.gpsData();
        outobj.timestamp = this.timestamp;
 
        outobj.lat = this.lat;
 
        outobj.latDir = this.latDir;
 
        outobj.lon = this.lon;
 
        outobj.lonDir = this.lonDir;
 
        outobj.alt = this.alt;
 
        outobj.utm_x = this.utm_x;
 
        outobj.utm_y = this.utm_y;
 
        return outobj;
    }
 
}

