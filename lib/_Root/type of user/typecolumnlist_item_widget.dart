import 'package:flutter/material.dart';

class TypecolumnlistItemWidget extends StatelessWidget {
  final bool isSelected; // Indicates if the item is selected
  final String roleName; // Role name to display in the tile
  final ValueChanged<bool?>? onChanged; // Callback function to handle tile tap

  const TypecolumnlistItemWidget({
    Key? key,
    required this.isSelected, // Required: Whether the item is selected
    required this.roleName, // Required: Name of the role to display
    this.onChanged, // Optional: Callback function for tile tap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 33, right: 33, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        // Adjust the radius as needed
        border: Border.all(
            color: Colors.blueAccent), // Adjust the border color as needed
      ),
      child: Container(
        margin: EdgeInsets.all(20), // Margin of 20 pixels on all sides
        child: ListTile(
          title: Text(roleName), // Display the role name
          leading: CircleAvatar(
            backgroundColor: isSelected ? Colors.blue : Colors.transparent,
            // Show check icon if selected, else show transparent avatar
            child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
          ),
          onTap: () {
            // Call the onChanged callback function if provided
            if (onChanged != null) {
              onChanged!(true);
            }
          },
        ),
      ),
    );
  }
}
