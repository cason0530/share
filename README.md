# share
share my file
网络数据封装解析（IP,UDP,TCP） 

 IP数据包也叫IP报文分组，传输在ISO网络7层结构中的网络层，它由IP报文头和IP报文用户数据组成，IP报文头的长度一般在20到60个字节之间，而一个IP分组的最大长度则不能超过65535个字节。 

一、下图为IP分组的报文头格式，报文头的前20个字节是固定的，后面的可变。
版本：占4位（bit），指IP协议的版本号。目前的主要版本为IPV4，即第4版本号，也有一些教育网和科研机构在使用IPV6。在进行通信时，通信双方的IP协议版本号必须一致，否则无法直接通信。 
首部长度：占4位（bit），指IP报文头的长度。最大的长度（即4个bit都为1时）为15个长度单位，每个长度单位为4字节（TCP/IP标准，DoubleWord），所以IP协议报文头的最大长度为60个字节，最短为上图所示的20个字节。 
服务类型：占8位（bit），用来获得更好的服务。其中的前3位表示报文的优先级，后面的几位分别表示要求更低时延、更高的吞吐量、更高的可靠性、更低的路由代价等。对应位为1即有相应要求，为0则不要求。 
总长度：16位（bit），指报文的总长度。注意这里的单位为字节，而不是4字节，所以一个IP报文的的最大长度为65535个字节。 
标识（identification）：该字段标记当前分片为第几个分片，在数据报重组时很有用。 
标志（flag）：该字段用于标记该报文是否为分片（有一些可能不需要分片，或不希望分片），后面是否还有分片（是否是最后一个分片）。 
片偏移：指当前分片在原数据报（分片前的数据报）中相对于用户数据字段的偏移量，即在原数据报中的相对位置。 
生存时间：TTL（Time to Live）。该字段表明当前报文还能生存多久。每经过1ms或者一个网关，TTL的值自动减1，当生存时间为0时，报文将被认为目的主机不可到达而丢弃。使用过Ping命令的用户应该有印象，在windows中输入ping命令，在返回的结果中即有TTL的数值。 
协议：该字段指出在上层（网络7层结构或TCP/IP的传输层）使用的协议，可能的协议有UDP、TCP、ICMP、IGMP、IGP等。 
首部校验和：用于检验IP报文头部在传播的过程中是否出错，主要校验报文头中是否有某一个或几个bit被污染或修改了。 
源IP地址：32位（bit），4个字节，每一个字节为0～255之间的整数，及我们日常见到的IP地址格式。 
目的IP地址：32位（bit），4个字节，每一个字节为0～255之间的整数，及我们日常见到的IP地址格式。

由于Delphi里面没有位域这个概念,所以定义结构的时候只能整字节了,挺怀恋C++或者Erlang的,有位域定义出来和使用起来都很方便了 
//IP包 
  TIPHeader = packed record 
    iph_verlen: byte;           // 版本和长度 
    iph_tos: byte;              // 服务类型 
    iph_length: word;           // 总长度,2个无符号字节所以只能65535 
    iph_id: word;               // 标识 
    iph_offset: word;           // 标志和片偏移 
    iph_ttl: byte;              // 生存时间 
    iph_protocol: byte;         // 协议 
    iph_xsum: word;             // 头校验和 
    iph_src: longword;          // 源地址 
    iph_dest: longword;         // 目的地址 
  end;
这个结构体有什么用呢?其实在嗅探的时候就很有用了.

二、TCP数据包的头
typedef struct _TCP_HEADER {
 USHORT nSourPort ;   // 源端口号16bit
 USHORT nDestPort ;   // 目的端口号16bit
 UINT nSequNum ;   // 序列号32bit
 UINT nAcknowledgeNum ; // 确认号32bit
 USHORT nHLenAndFlag ;  // 前4位：TCP头长度；中6位：保留；后6位：标志位16bit
 USHORT nWindowSize ;  // 窗口大小16bit
 USHORT nCheckSum ;   // 检验和16bit
 USHORT nrgentPointer ;  // 紧急数据偏移量16bit
} TCP_HEADER, *PTCP_HEADER ;

三、UDP数据包的头
typedef struct _UDP_HEADER {
 USHORT nSourPort ;   // 源端口号16bit
 USHORT nDestPort ;   // 目的端口号16bit
 USHORT nLength ;   // 数据包长度16bit
 USHORT nCheckSum ;   // 校验和16bit
} UDP_HEADER, *PUDP_HEADER ;

进入协议栈的过程:(从协议栈出来刚好相反)


四、ICMP头和报文校验和的计算
////////////////////////////////定义ICMP包头
typedef struct _ICMP_HEADER {
 BYTE bType ;   // 类型8bit
 BYTE bCode ;   // 代码8bit
 USHORT nCheckSum ;  // 校验和16bit
 USHORT nId ;   // 标识，本进程ID16bit
 USHORT nSequence ;  // 序列号16bit
 UINT nTimeStamp ; // 可选项，这里为时间，用于计算时间32bit
} ICMP_HEADER, *PICMP_HEADER ;

/////////////////////////////////

发送ICMP报文时，必须由程序自己计算校验和，将它填入ICMP头部对应的域中。校验和的计算方法是：

将数据以字（16位）为单位累加到一个双字中(强转换双字类型)，如果数据长度为奇数(奇数个字节)，最后一个字节将被扩展到字，累加的结果是一个双字，

最后将这个双字的高16位和低16位相加后取反，便得到了校验和！

// 计算ICMP包校验值
// 参数1：ICMP包缓冲区
// 参数2：ICMP包长度
USHORT GetCheckSum ( LPBYTE lpBuf, DWORD dwSize )
{
 DWORD dwCheckSum = 0 ;
 USHORT* lpWord = (USHORT*)lpBuf ;


 // 累加
 while ( dwSize > 1 )
 {
  dwCheckSum += *lpWord++ ;
  dwSize -= 2 ;
 }


 // 如果长度是奇数
 if ( dwSize == 1 )
  dwCheckSum += *((LPBYTE)lpWord) ;


 // 高16位和低16位相加
 dwCheckSum = ( dwCheckSum >> 16 ) + ( dwCheckSum & 0xFFFF ) ;


 // 取反
 return (USHORT)(~dwCheckSum ) ;
}
