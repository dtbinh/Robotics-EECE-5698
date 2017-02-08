#!/usr/bin/env python
# simple node that gets params and publishes them

import rospy
from std_msgs.msg import String


def read_params():
    rospy.init_node('read_params')

    global_param = rospy.get_param("/global_param")
    rospy.loginfo("%s is %s", rospy.resolve_name('/global_param'), global_param)

    # fetch topic name
    topic_name = rospy.get_param('~topic_name')
    rospy.loginfo("%s is %s", rospy.resolve_name('~topic_name'), topic_name)

    # fetch a group (dictoinary) of parameters
    someGroup = rospy.get_param('someGroup')
    p, i, d = someGroup['P'], someGroup['I'], someGroup['D']
    rospy.loginfo("someGroup are %s, %s, %s", p, i, d)

    # set Parameters
    rospy.loginfo("setting parameters")
    rospy.set_param('list_of_floats', [1.,2.,3.,4.])
    rospy.set_param('to_delete', 'baz')
    rospy.loginfo('...parameters have been set')
    
    # delete a paremeter
    if rospy.has_param('to_delete'):
        rospy.delete_param('to_delete')
        rospy.loginfo("deleted %s parameter"%rospy.resolve_name('to_delete'))
    else:
        rospy.loginfo('parameters %s was already deleted'%rospy.resolve_name('to_delete'))



    pub = rospy.Publisher(topic_name, String, queue_size=10)
    while not rospy.is_shutdown():
        pub.publish(global_param)
        rospy.loginfo(global_param)
        rospy.sleep(1)


if __name__ == '__main__':
    try:
        read_params()
    except rospy.ROSInterruptException: pass
