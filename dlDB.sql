CREATE DATABASE dlDB;
USE dlDB;

CREATE TABLE adminUser(
  adminname varchar(20) primary key not null,
  password varchar(20) not null
)

INSERT INTO adminUser VALUES ('admin','admin');

CREATE TABLE fileInfo(
  fileID int identity(1,1) primary key not null,
  fileTitle varchar(50) not null,
  lastModified datetime  not null,
  fileSize int,
  fileImage image,
  hits int not null,
  catlID char(2) not null,
  description text default '',
  filePath varchar(100),
  fileName varchar(100),
  status char(1) not null
)

INSERT INTO fileInfo(fileTitle,lastModified,fileSize,hits,catlID,description,filePath,fileName,status) 
	VALUES ('111111111','2014-06-04 16:50:11',35840,2,'5','111111111','/software/1241425971921.doc','计算机技术系.doc',1);
INSERT INTO  fileInfo(fileTitle,lastModified,fileSize,hits,catlID,description,filePath,fileName,status) 
	VALUES ('Pretty Girl','2014-06-04 12:47:57',9892,1,'1','美图！','/software/1241412477265.GIF','pretty_girl.GIF',1);
INSERT INTO  fileInfo(fileTitle,lastModified,fileSize,hits,catlID,description,filePath,fileName,status) 
	VALUES ('爱就一个字','2014-06-04 12:49:19',4234310,1,'3','张信哲的歌曲！好听！','/software/1241412559437.mp3','爱就一个字.mp3',2);
INSERT INTO  fileInfo(fileTitle,lastModified,fileSize,hits,catlID,description,filePath,fileName,status) 
	VALUES ('小笑话','2014-06-04 12:51:06',386757,0,'2','搞笑笑话！\r\n哈哈！\r\n哈哈！','/software/1241412666531.swf','笑话.swf',1);
INSERT INTO  fileInfo(fileTitle,lastModified,fileSize,hits,catlID,description,filePath,fileName,status) 
	VALUES ('ebook','2014-06-04 12:57:06',410025,0,'5','英语8000句的帮助文档！','/software/1241413026578.chm','English8000.chm',1);

CREATE TABLE comment(
  commID int identity(1,1) primary key not null,
  fileID int not null,
  commentator varchar(20),
  content varchar(200) not null,
  commDate datetime
)

CREATE TABLE fileCatl(
  catlID char(2) primary key not null,
  description varchar(50),
  folder varchar(100) not null
)