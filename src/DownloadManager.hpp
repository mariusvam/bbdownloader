#ifndef DOWNLOADMANAGER_HPP_
#define DOWNLOADMANAGER_HPP_

#include <QtCore>

/*!
 *  @class     DownloadManager
 *  @brief     DownloadManager class
 *  @details   Handles URL generation and filesystem work
 *  @author    Thurask
 *  @date      2014-2015
 */
class DownloadManager: public QObject
{
    Q_OBJECT

public:
    DownloadManager();

    public Q_SLOTS:

    /*!
     * @brief   Return debrick OS links
     * @return  Returns oslinks QString
     */
    QString returnOsLinks();

    QString returnCoreLinks();

    QString returnRadioLinks();

    void setExportUrls(QString swversion, QString hashedswversion, QString osversion,
            QString radioversion, bool verizon, bool winchester, bool passport, bool core,
            bool qcom, bool lseries, bool nseries, bool aseries, bool jakarta, bool aquarius,
            bool china, bool sdk, bool laguna);

    void saveTextFile(QString urls, QString swrelease);

    void exportLinks(QString swrelease);

    void copyLinks();

    void copyOsLinks();

    void copyRadioLinks();

    QString returnLinks();

    QString returnFilename();

    QString readTextFile(QString uri, QString mode);

    void setDefaultDir(QString dir);

    QString defaultDir();

    QString getcwd();

    private Q_SLOTS:

    void setOsLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester,
            bool passport, bool qcom, bool jakarta, bool china, bool sdk);

    void setCoreLinks(QString hashedswversion, QString osversion, bool verizon, bool winchester,
            bool passport, bool qcom, bool jakarta, bool dummy, bool china, bool sdk);

    void setRadioLinks(QString hashedswversion, QString osversion, QString radioversion,
            bool winchester, bool passport, bool lseries, bool nseries, bool aseries, bool jakarta,
            bool aquarius, bool laguna);

    private:

    QString appversion;

    QString exporturls;

    QString radiolinks;

    QString oslinks;

    QString corelinks;

    QString filename;

    QString default_dir;
};

#endif /* DOWNLOADMANAGER_HPP_ */
