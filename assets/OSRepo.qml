import bb.cascades 1.2
import bb.data 1.0
import bb.system 1.2

Sheet {
    id: osRepo
    signal releaseSelected(string reposoftware, string repoos, string reporadio)
    content: Page {
        titleBar: TitleBar {
            title: "Software List"
            dismissAction: ActionItem {
                title: "Close"
                onTriggered: {
                    osRepo.close()
                }
            }
            acceptAction: ActionItem {
                title: "Refresh"
                onTriggered: {
                    repoDataSource.load();
                }
            }
        }
        Container {
            Header {
                title: "Info"
            }
            Label {
                text: "If there's a new OS, notify me or fork this repo, update xml/repo.xml and make a pull request:\nhttps://github.com/thurask/thurask.github.io"
                content.flags: TextContentFlag.ActiveText
                textStyle.textAlign: TextAlign.Center
                multiline:true
            }
            Header {
                title: "Known Software (Be Patient, It's Retrieving A Database)"
            }
            Label {
                id: errorlabel
                text: "Make sure you're connected to the Internet, \nhave data service and Github is up."
                multiline: true
                visible: false
            }
            ListView {
                id: listView
                dataModel: repoDataModel
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                        Container {
                            Label {
                                text: ""
                            }
                        }
                    },
                    ListItemComponent {
                        type: "item"
                        Container {
                            Label {
                                text: "OS: " + (ListItemData.trueos == "" ? ListItemData.os : ListItemData.trueos)
                                textStyle.fontWeight: FontWeight.Bold
                                multiline: true
                            }
                            Label {
                                text: "Software Release: " + ListItemData.software + " | Radio: " + ListItemData.radio
                            }
                            Label {
                                text: ListItemData.notes
                                textStyle.fontSize: FontSize.Small
                                multiline: true
                            }
                            Divider {
                            }
                        }
                    }
                ]
                onTriggered: {
                    var indexi = repoDataModel.data(indexPath);
                    osRepo.releaseSelected(indexi.software, (indexi.trueos == "" ? indexi.os : indexi.trueos), indexi.radio)
                    xmlToast.show();
                }
            }
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: repoDataModel
            sortingKeys: [
            "os"
            ]
            sortedAscending: false
            grouping: ItemGrouping.ByFullValue
        },
        DataSource {
            id: repoDataSource
            remote: true
            source: "http://thurask.github.io/xml/repo.xml"
            query: "repo/release"
            type: DataSourceType.Xml
            onDataLoaded: {
                errorlabel.visible = false;
                repoDataModel.clear();
                repoDataModel.insertList(data)
            }
            onError: {
                errorlabel.visible = true;
            }
        },
        SystemToast {
            id: xmlToast
            body: "Values copied to OS Downloader"
        }
    ]
    onCreationCompleted: {
        repoDataSource.load();
    }
}